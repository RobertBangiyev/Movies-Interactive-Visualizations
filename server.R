#dataset link: https://www.kaggle.com/stefanoleone992/imdb-extensive-dataset
#resources used: www.r-graph-gallery.com, dplyr.tidyverse.org, ggplot2.tidyverse.org

library(shiny)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(tidyr)

#Set working directory to current folder, or include entire path to file before running the app
original <- read.csv('IMDb movies CLEANED.csv')
# original <- read.csv('C:/Users/rbang/Desktop/Robert College/Data Visualization/Project 2/IMDb movies CLEANED.csv')

shinyServer(function(input, output) {
    output$grossPlot <- renderPlot({
        a <- original %>% filter(!is.na(budget))
        a <- a %>% filter(!is.na(usa_gross_income))
        c <- select(a, budget, usa_gross_income, language)
        d <- c %>% group_by(budget, language) %>% summarise_at(vars(usa_gross_income), list(usa_gross_income = mean))
        options(scipen=10000)
        if(input$lang != 'Any') {
            c <- filter(c, language == input$lang)
            d <- filter(d, language == input$lang)
        }
        if(input$avgcheck == FALSE) {
            ggplot(c, aes(x=budget, y=usa_gross_income, color=language)) + geom_point(size = input$dotsize) + 
                scale_colour_manual(values = c("English" = "orange", "Not English" = "blue")) + geom_smooth() + 
                labs(title=input$titlechange, x="Budget", y='USA Gross', color="Language") + 
                xlim(input$budgetrange[1], input$budgetrange[2]) + ylim(input$grossrange[1], input$grossrange[2]) + 
                theme(plot.title = element_text(size = 30, face = "bold", hjust = 0.5))
        }
        else {
            ggplot(d, aes(x=budget, y=usa_gross_income, color=language)) + geom_point(size = input$dotsize) + 
                scale_colour_manual(values = c("English" = "orange", "Not English" = "blue")) + geom_smooth() + 
                labs(title=input$titlechange, x="Budget", y='Average USA Gross', color="Language") + 
                xlim(input$budgetrange[1], input$budgetrange[2]) + ylim(input$grossrange[1], input$grossrange[2]) + 
                theme(plot.title = element_text(size = 30, face = "bold", hjust = 0.5))
        }
    })
    
    output$yearPlot <- renderPlot({
        budgeting <- original %>% filter(!is.na(budget))
        budgetyearly <- budgeting %>% group_by(year) %>% summarise_at(vars(budget), list(budget = mean))
        budgetyearly$year <- as.numeric(as.character(budgetyearly$year))
        
        incoming <- original %>% filter(!is.na(usa_gross_income))
        incomeyearly <- incoming %>% group_by(year) %>% summarise_at(vars(usa_gross_income), list(usa_gross_income = mean))
        incomeyearly$year <- as.numeric(as.character(incomeyearly$year))
        
        durationing <- original %>% filter(!is.na(duration))
        durationyearly <- durationing %>% group_by(year) %>% summarise_at(vars(duration), list(duration = mean))
        durationyearly$year <- as.numeric(as.character(durationyearly$year))
        
        if(input$yaxis == 'Average Movie Duration') {
            outplot <- ggplot(durationyearly, aes(x=year, y=duration, group=1))
        }
        else if(input$yaxis == 'Average Budget') {
            outplot <- ggplot(budgetyearly, aes(x=year, y=budget, group=1))
        }
        else {
            outplot <- ggplot(incomeyearly, aes(x=year, y=usa_gross_income, group=1))
        }
        
        outplot <- outplot + geom_line(linetype = input$line, size=input$yearlinesize, color=input$linecol) + 
            geom_point(size = input$yeardotsize, color=input$dotcol) + 
            labs(title=input$yeartitlechange, x="Year", y=input$yaxis) + theme(plot.title = element_text(size = 30, face = "bold", hjust = 0.5)) + 
            xlim(input$yearrange[1], input$yearrange[2])
        outplot
    })
    
    output$genrePlot <- renderPlot({
        genreDf <- original %>% filter(!is.na(usa_gross_income))
        genreDf <- select(genreDf, genre, usa_gross_income)
        genreDf <- genreDf %>%
            separate_rows(genre, sep = ', ')
        genreLeft <- genreDf %>% group_by(genre) %>% summarise(Count = n())
        genreRight <- genreDf %>% group_by(genre) %>% summarise_at(vars(usa_gross_income), list(usa_gross_income = mean))
        genres <- merge(genreLeft,genreRight,by="genre")
        
        genres <- filter(genres, genre %in% input$genres)
        colourCount <- length(unique(genres$genre))
        ggplot(genres, aes_string(x='genre', y=input$genreradio, fill = 'genre')) + geom_bar(stat = "identity") + labs(title=input$genretitlechange, x="Genre", y="Movies Released") +
            scale_fill_manual(values = colorRampPalette(brewer.pal(9, input$pal))(colourCount)) + theme(legend.position="none", plot.title = element_text(size = 30, face = "bold", hjust = 0.5))
    })
    
    output$scorePlot <- renderPlot({
        scores <- data.frame(original$avg_vote)
        ggplot(scores, aes(x=original.avg_vote)) + geom_histogram(bins = input$bins, fill=rgb(input$red,input$green,input$blue), color=input$bordercol) + 
            labs(title=input$titlechangefinal, x="Average Score per Movie", y="Frequency") + theme(plot.title = element_text(size = input$fontchange, face = "bold", hjust = 0.5))
    })
    
})
