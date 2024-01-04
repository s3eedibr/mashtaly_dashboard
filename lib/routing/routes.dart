const rootRoute = "/";

const overviewPageDisplayName = "Statistics";
const overviewPageRoute = "/overview";

const plantPageDisplayName = "Plants";
const plantsPageRoute = "/Plants";

const accountsPageDisplayName = "Accounts";
const accountsPageRoute = "/Accounts";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

const ReportingPageDisplayName = "Reports";
const ReportingPageRoute = "/Reports";

const salePlantPageDisplayName = "Plants for sale";
const salePlantPageRoute = "/SalePlants";

const postPlantPageDisplayName = "Articles";
const postPlantPageRoute = "/Articles";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(postPlantPageDisplayName, postPlantPageRoute),
  MenuItem(salePlantPageDisplayName, salePlantPageRoute),
  MenuItem(ReportingPageDisplayName, ReportingPageRoute),
  MenuItem(accountsPageDisplayName, accountsPageRoute),
  MenuItem(plantPageDisplayName, plantsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
