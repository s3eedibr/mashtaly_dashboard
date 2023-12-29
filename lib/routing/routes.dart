const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const plantPageDisplayName = "Plant";
const plantsPageRoute = "/Plant";

const accountsPageDisplayName = "Accounts";
const accountsPageRoute = "/Accounts";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

const ReportingPageDisplayName = "Reporting";
const ReportingPageRoute = "/Reporting";

const sellPlantPageDisplayName = "SellPlant";
const sellPlantPageRoute = "/SellPlant";

const postPlantPageDisplayName = "Posts";
const postPlantPageRoute = "/Posts";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(plantPageDisplayName, plantsPageRoute),
  MenuItem(accountsPageDisplayName, accountsPageRoute),
  MenuItem(sellPlantPageDisplayName, sellPlantPageRoute),
  MenuItem(postPlantPageDisplayName, postPlantPageRoute),
  MenuItem(ReportingPageDisplayName, ReportingPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
