task_id <- Sys.getenv("SLURM_ARRAY_TASK_ID")
task_id <- as.numeric(task_id)

library(INLA)
library(tidyverse)

dat <- data.frame(y = rnorm(1000),
                   x = rnorm(1000),
                   task = rep(1:4, each = 250))

dat_sub <- dat %>% 
  filter(
    task == task_id
    )

fit <- inla(y ~ x,
            data = dat_sub)

save(fit, file = paste0("fit_", task_id, ".Rda"))
