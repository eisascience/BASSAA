
library(shinydashboard)

dashboardPage(
  dashboardHeader(),
  dashboardHeader(dropdownMenuOutput("messageMenu")),
  dashboardSidebar(),
  dashboardBody()
)
