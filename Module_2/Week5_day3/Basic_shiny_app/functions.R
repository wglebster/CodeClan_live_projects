# function to plot medals

medal_plot <- function(t, s){
  olympics_overall_medals %>% 
    filter(team == t) %>% 
    filter(season == s) %>% 
    ggplot() +
    aes(x = medal, y = count, fill = medal) +
    geom_col()
}