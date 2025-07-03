library(tidyverse)
library(janitor)

adorn_all <- function(x) {
  x <- x |> janitor::adorn_percentages("col") |> adorn_pct_formatting() |> adorn_ns()
  return(x)
}

sentences <- read_csv("./historical-data/sentences.csv") |>
  as_tibble() |>
  janitor::clean_names()

sentences_sum <- sentences |>
  arrange(sentence) |> # Set in chronological order so first() and last() will work for us
  mutate(
    outcome_clean = case_when(
      str_detect(outcome_of_sentence, "(?i)executed") ~ "Executed",
      str_detect(outcome_of_sentence, "(?i)resentenced to (life|time)") ~ "Resentenced to Life or Less",
      str_detect(outcome_of_sentence, "(?i)active|resentenced to death") ~ "Currently on Death Row",

    )
  ) |>
  reframe(
    .by = c(defendant, sentence, year),
    n_sentences = n(),
    name = unique(name),
    origin_state = first(jurisdiction),
    origin_county = first(sub_jurisdiction),
    county = paste0(unique(sub_jurisdiction), collapse = ", "),
    states = paste0(unique(state_abbreviation), collapse = ", "),
    list_outcomes = paste0(outcome_of_sentence, collapse = ", "),
    final_outcome = last(outcome_of_sentence),
    list_outcomes_clean = paste0(outcome_clean, collapse = ", "),
    final_outcome_clean = last(outcome_clean)
  )

sentences_sum |>
  count(final_outcome, final_outcome_clean) |>
  arrange(desc(n))

ok_sentences <- sentences_sum |>
  filter(
    origin_state == "Oklahoma"
  )

executions <- read_csv("./historical-data/executions.csv") |>
  as_tibble() |>
  clean_names()

ok_executions <- data |>
  filter(state == "Oklahoma")


#

ok_sentences |>
  filter(final_outcome != "Active Death Sentence") |>
  count(final_outcome, sort = T) |>
  adorn_all()

ok_sentences |>
  count(decade = paste0(substr(year, 1, 3), "0") |> as.numeric(),
        final_outcome) |>
  ggplot(aes(x = decade, y = n, fill = final_outcome)) +
  geom_col(color = "black") +
  ggthemes::theme_clean() +
  ggthemes::scale_fill_calc()
