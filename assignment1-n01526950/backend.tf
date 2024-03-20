terraform {
  backend "azurerm" {
    storage_account_name = "tfstateno1526950"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
    access_key           = "a6fuDc4tAFx8omJCyyeH48CroZ+qUR1HbJBF+EuhShjKiTd8JfHd2t+OPpwL/4VNbowx75WJr20++AStvl804w=="
  }
}
