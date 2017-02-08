func tableView(tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
{
    return 1
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
{
    let MyCustomCell = tableView.dequeueReusableCell(withIdentifier: myCell, for: indexPath as IndexPath)
    MyCustomCell.textLabel?.text=dataStore.allFlavors()[indexPath.row]
    return MyCustomCell
}




func numberOfSections(in tableView: UITableView) -> Int{
    return 1
}

func tableView(_ TVFriendsOutlet: UITableView,
               numberOfRowsInSection: Int) -> Int {
    return dataStore.allFlavors().count
}

}

class IceCreamStore
{
    private let flavors = ["Vanilla", "Chocolate", "Strawberry", "Coffee", "Cookies & Cream", "Rum Raisins", "Mint Chocolate Chip", "Peanut Butter Cup"]
    
    func allFlavors() -> [String]
    {
        return flavors
}
