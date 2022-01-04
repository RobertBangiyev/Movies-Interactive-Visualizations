library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Movies"),
    tags$p("By Robert Bangiyev"),
    tags$a("Dataset Link", href="https://www.kaggle.com/stefanoleone992/imdb-extensive-dataset"),
    br(),
    br(),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("lang", "Select Language:",
                        choices = c('English', 'Not English', 'Any'), selected = 'Any'),
            sliderInput("budgetrange", label = "Budget Range", min = 0, 
                        max = 356000000, value = c(0, 356000000)),
            sliderInput("grossrange", label = "Gross Range", min = 30, 
                        max = 936662225, value = c(30, 936662225)),
            numericInput("dotsize", "Size of Dots:", 1, min = 1, max = 10),
            textInput("titlechange", "Title", "Relationship Between Budget and USA Gross"),
            checkboxInput("avgcheck", label = "Use USA Gross Average", value = FALSE),
        ),
        
        mainPanel(
            plotOutput("grossPlot")
        )
    ),
    br(),
    br(),
    sidebarLayout(
        sidebarPanel(
            selectInput("yaxis", "Select Y-Axis Variable:",
                        choices = c('Average Budget', 'Average USA Gross Income', 'Average Movie Duration'), selected = 'Average Budget'),
            sliderInput("yearrange", label = "Year Range", min = 1890, 
                        max = 2020, value = c(1890, 2020)),
            radioButtons("line", "Select Line Type:",
                         c("Solid" = "solid",
                           "Dashed" = "dashed",
                           "Dotted" = "dotted")),
            numericInput("yeardotsize", "Size of Dots:", 1, min = 1, max = 10),
            numericInput("yearlinesize", "Line Thickness:", 1, min = 1, max = 3, step = 0.2),
            selectInput("dotcol", "Select Dot Color:",
                        choices = c('Black' = 'black', 'Blue' = 'blue', 'Red' = 'red', 'Green' = 'green', 'Yellow' = 'yellow', 'Orange' = 'orange', 'Purple' = 'purple'), 
                        selected = 'Black'),
            selectInput("linecol", "Select Line Color:",
                        choices = c('Black' = 'black', 'Blue' = 'blue', 'Red' = 'red', 'Green' = 'green', 'Yellow' = 'yellow', 'Orange' = 'orange', 'Purple' = 'purple'), 
                        selected = 'Black'),
            textInput("yeartitlechange", "Title", "Changes in Budget, Gross, and Duration Over Time")
        ),
        
        mainPanel(
            plotOutput("yearPlot")
        )
    ),
    br(),
    br(),
    sidebarLayout(
        sidebarPanel(
            radioButtons("genreradio", "Select Y-Axis:", choices = 
                             c("Movies Released" = "Count",
                               "Average US Gross Income" = "usa_gross_income")),
            checkboxGroupInput("genres", "Choose genres to display:",
                               choiceNames =
                                   c('Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime', 'Documentary', 'Drama',
                                     'Family', 'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music', 'Musical', 'Mystery', 'Romance',
                                     'Sci-Fi', 'Sport', 'Thriller', 'War', 'Western'),
                               choiceValues =
                                   c('Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime', 'Documentary', 'Drama',
                                     'Family', 'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music', 'Musical', 'Mystery', 'Romance',
                                     'Sci-Fi', 'Sport', 'Thriller', 'War', 'Western'),
                               selected = 
                                   c('Action', 'Adventure', 'Animation', 'Biography', 'Comedy', 'Crime', 'Documentary', 'Drama',
                                     'Family', 'Fantasy', 'Film-Noir', 'History', 'Horror', 'Music', 'Musical', 'Mystery', 'Romance',
                                     'Sci-Fi', 'Sport', 'Thriller', 'War', 'Western'), inline=TRUE
            ),
            selectInput("pal", "Select Color Palette:",
                        choices = c('Set1', 'Set2', 'Set3', 'Pastel2', 'Pastel1', 'Paired', 'Dark2', 'Accent', 'Spectral'), 
                        selected = 'Set1'),
            textInput("genretitlechange", "Title", "Movie Releases and Average USA Gross per Genre")
            
        ),
        
        mainPanel(
            plotOutput("genrePlot")
        )
    ),
    br(),
    br(),
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 100,
                        value = 20),
            sliderInput("red",
                        "Red Value:",
                        min = 0,
                        max = 1.0,
                        value = 0,
                        step = 0.1),
            sliderInput("green",
                        "Green Value:",
                        min = 0,
                        max = 1.0,
                        value = 0,
                        step = 0.1),
            sliderInput("blue",
                        "Blue Value:",
                        min = 0,
                        max = 1.0,
                        value = 0,
                        step = 0.1),
            selectInput("bordercol", "Select Border Color:",
                        choices = c('White' ='white', 'Black' = 'black', 'Blue' = 'blue', 'Red' = 'red', 'Green' = 'green', 'Yellow' = 'yellow', 'Orange' = 'orange', 'Purple' = 'purple'), 
                        selected = 'Black'),
            textInput("fontchange", "Title Font:", "30"),
            textInput("titlechangefinal", "Title", "Movie Scores")
            
        ),
        
        mainPanel(
            plotOutput("scorePlot")
        )
    )
))
