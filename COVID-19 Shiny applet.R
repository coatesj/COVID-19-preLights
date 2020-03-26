#
# Code relating to the preprints in response to CODIV-19 graphic 
# Maintained by the team @preLights
#
# Last update: 
#

#Load relevant libraries
library(shiny)
library(timevis)

#Import data
readRDS("final_data.rds") -> final_data

# Define UI for application
    ui = fluidPage(
        
        titlePanel("Preprints in response to COVID-19, maintained by the @preLights team"),
        
        tags$style(
          ".event { background: darksalmon; }
      .preprint { background: deepskyblue; }
      .bad { background: moccasin; }"
        ),
        timevisOutput("timeline"),

#Add buttons to allow user to control view
        actionButton("btn", "Fit all items"),
        actionButton("btn2", "Center on first reported case"),
    
    
#Add rows underneath containing additional text
    br(),
    br(),
    
fluidRow(
  column(2,
         h4(" ")),
  h3("Key: Red = Event, Blue = Preprint, Orange = falsified/questionable preprint")),

br(),

    fluidRow(
      column(2,
             h4("Authors et al / preprint title")),
      br(),
      p("I am interested in immune cell biology, particularly how immune cells are capable of performing such wide ranging functions and how they adapt to different environmental cues such as glucose or hypoxia. During my masters degree, I investigated the presence of fibroblast subtypes and the role of PGE2 signalling in fibrosis. I completed my PhD in Iwan Evans' lab at the University of Sheffield investigating the existence of macrophage subtypes in Drosophila. I am currently a postdoctoral researcher based in Cambridge. In my current research I have branched out into the adaptive immune response and I am investigating the impact of hypoxia on the transcriptional and epigenetic landscape of cytotoxic T cells. I have a wide interests in cell/molecular biology, metabolism and tumour immunology with a penchant for microscopy and big data.")),
    
    br(),
    
    fluidRow(
      column(2,
             h4("Authors et al / preprint title")),
      br(),
      p("I am interested in immune cell biology, particularly how immune cells are capable of performing such wide ranging functions and how they adapt to different environmental cues such as glucose or hypoxia. During my masters degree, I investigated the presence of fibroblast subtypes and the role of PGE2 signalling in fibrosis. I completed my PhD in Iwan Evans' lab at the University of Sheffield investigating the existence of macrophage subtypes in Drosophila. I am currently a postdoctoral researcher based in Cambridge. In my current research I have branched out into the adaptive immune response and I am investigating the impact of hypoxia on the transcriptional and epigenetic landscape of cytotoxic T cells. I have a wide interests in cell/molecular biology, metabolism and tumour immunology with a penchant for microscopy and big data."))
    )
    
# Define server logic  
    server <- function(input, output, session) {
        output$timeline <- renderTimevis({
            timevis(final_data)
        })
        
#Make buttons work
        observeEvent(input$btn, {
            fitWindow("timeline", list(animation = TRUE))
        })
        observeEvent(input$btn2, {
            centerItem("timeline", 1, (animation = TRUE))
        })
    }
  
# Run the application 
shinyApp(ui = ui, server = server)
