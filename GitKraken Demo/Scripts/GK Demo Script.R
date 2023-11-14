# Cara Gallagher
# November 15th, 2023
# GitKraken Demo 
# Example script

#------------------------------------------------#

####  Packages: #### 
library(tidyverse)
library(palmerpenguins)

#### Dataset ####
data(package = 'palmerpenguins')

#### Let's make a summarized dataset and save it ####
mean_outs <- penguins %>% 
  group_by(species, sex) %>% 
  summarize(across(where(is.numeric), mean, na.rm = TRUE))

write.csv(mean_outs, "Data/MeansBySpSex.csv", row.names = FALSE)

#### Now let's make a plot ####
## Plots from allisonhorst.github.io/palmerpenguins/articles/examples.html#facets

# Bill length by depth 
bill_len_dep <- ggplot(data = penguins,
                       aes(x = bill_length_mm,
                           y = bill_depth_mm,
                           group = species)) +
  geom_point(aes(color = species, 
                 shape = species),
             size = 3,
             alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, aes(color = species)) +
  scale_color_manual(values = c("darkorange","purple","cyan4")) +
  labs(title = "Penguin bill dimensions",
       subtitle = "Bill length and depth for Adelie, Chinstrap and Gentoo Penguins at Palmer Station LTER",
       x = "Bill length (mm)",
       y = "Bill depth (mm)",
       color = "Penguin species",
       shape = "Penguin species") +
  theme(legend.position = c(0.85, 0.15),
        plot.title.position = "plot",
        plot.caption = element_text(hjust = 0, face= "italic"),
        plot.caption.position = "plot")

bill_len_dep
ggsave("Figures/BillLengthDepth.png", bill_len_dep, width = 7, height = 6)

# Using facets
BM_flip_len_sex <- ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = sex)) +
  scale_color_manual(values = c("darkorange","cyan4"), na.translate = FALSE) +
  labs(title = "Penguin flipper and body mass",
       subtitle = "Dimensions for male and female Adelie, Chinstrap and Gentoo Penguins at Palmer Station LTER",
       x = "Flipper length (mm)",
       y = "Body mass (g)",
       color = "Penguin sex") +
  theme(legend.position = "bottom",
        plot.title.position = "plot",
        plot.caption = element_text(hjust = 0, face= "italic"),
        plot.caption.position = "plot") +
  facet_wrap(~species)

BM_flip_len_sex
ggsave("Figures/BodyMassFlipperLengthSex.png", BM_flip_len_sex, width = 7, height = 6)



