import js.jquery.JQuery;
import upgrades.OneTimeUpgrade;
import upgrades.RebuyableUpgrade;
import upgrades.ResourceUpgrade;

class UpdateUI {
	
	public static function updateAll(): Void{
		updateAllResources();
		updateAllResourceUpgrades();
	}
	
	public static function updateAllResources(): Void{
		for (i in Main.resourceArray){
			updateResource(i);
		}
	}
	
	public static function updateResource(resource: Resource): Void{
		new JQuery("#" + resource.getName() + "Amount").text(resource.format());
		new JQuery("#" + resource.getName() + "Second").text(Util.formatDecimal((resource.plus - resource.autoCost)));
	}
	
	public static function updateAllResourceUpgrades(): Void{
		for (i in Main.upgradeArray){
			updateResourceUpgrade(i);
			updateResourceUpgradeButton(i);
		}
	}
	
	public static function updateResourceUpgrade(upgrade: ResourceUpgrade): Void{
		new JQuery("#" + upgrade.getName() + "Count").text(upgrade.amount);
		new JQuery("#" + upgrade.getName() + "Money").text(upgrade.format("money"));
		new JQuery("#" + upgrade.getName() + "Food").text(upgrade.format("food"));
		new JQuery("#" + upgrade.getName() + "Wood").text(upgrade.format("wood"));
		new JQuery("#" + upgrade.getName() + "Metal").text(upgrade.format("metal"));
		if (upgrade.getId() == 0){
			new JQuery("#" + upgrade.getName() + "Gain").text(Util.formatDecimal(upgrade.getResource().updatePlus() *
				upgrade.getResource().updateBarInc() / upgrade.amount));
		}
		updateResourceUpgradeButton(upgrade);
	}
	
	public static function updateResourceUpgradeButton(upgrade: ResourceUpgrade): Void{
		if (upgrade.isBuyable()){
			new JQuery("#" + upgrade.getName()).removeClass("disabled");
		} else {
			new JQuery("#" + upgrade.getName()).addClass("disabled");
		}	
	}
	public static function updateUpgrade(upgrade: Dynamic){
		
	}
	
	public static function updateAllUpgradeButtons(){
		for (i in Main.buildingArray){
			updateUpgradeButton(i);
		}
	}
	
	public static inline var MAXRESOURCERESEARCHES = 3;
	public static function updateUpgradeButton(upgrade: Dynamic){
		if (upgrade.bought == true && upgrade.getId() >= 10 && upgrade.getId() <= 69 && upgrade.getId() % 10 != MAXRESOURCERESEARCHES){
			upgrade.visible = false;
		}
		if (upgrade.visible){
			new JQuery("#" + upgrade.getName()).removeClass("hidden");
		} else {
			new JQuery("#" + upgrade.getName()).addClass("hidden");
		}
		if (upgrade.isBuyable()){
			new JQuery("#" + upgrade.getName()).removeClass("disabled");
		} else {
			new JQuery("#" + upgrade.getName()).addClass("disabled");
		}	
	}
	
	public static function displayUI(evolution: Int){
		if (evolution >= 1){
			new JQuery("#metalBlock").removeClass("hidden");
			new JQuery("#metal").removeClass("hidden");
			new JQuery("#money").removeClass("hidden");
			new JQuery("#foodUpgrade2").removeClass("hidden");
			new JQuery("#woodUpgrade2").removeClass("hidden");
			new JQuery("#metalUpgrade2").removeClass("hidden");
			new JQuery("#evolution1").addClass("hidden");
			new JQuery("#evolution2").removeClass("hidden");
			Main.moneyTimer.run = Main.addMoney;
			Main.metal.setupBar();
		} 
		if (evolution >= 2){
			new JQuery("#foodUpgrade1").removeClass("hidden");
			new JQuery("#woodUpgrade1").removeClass("hidden");
			new JQuery("#metalUpgrade1").removeClass("hidden");
			new JQuery("#foodUpgrade3").removeClass("hidden");
			new JQuery("#woodUpgrade3").removeClass("hidden");
			new JQuery("#metalUpgrade3").removeClass("hidden");
			new JQuery("#construction").removeClass("hidden");
			new JQuery("#house").removeClass("hidden");
			new JQuery("#evolution2").addClass("hidden");
			new JQuery("#evolution3").removeClass("hidden");
		}
		if (evolution >= 3){
			new JQuery("#farm").removeClass("hidden");
			new JQuery("#lumberMill").removeClass("hidden");
			new JQuery("#metalMine").removeClass("hidden");
			new JQuery("#goldMine").removeClass("hidden");
			new JQuery("#tax").removeClass("hidden");
			new JQuery("#skills").removeClass("hidden");
		}
		if (evolution >= 4){
			new JQuery("#research").removeClass("hidden");
		}
	}
	
	public static function hireFire(action: String){
		//lazy code, but whatever
		switch(action){
			case "hire":
				new JQuery("#hire").addClass("disabled");
				new JQuery("#fire").removeClass("disabled");
				new JQuery("#newFarmer").show();
				new JQuery("#newWoodcutter").show();
				new JQuery("#newMiner").show();
				new JQuery("#newFarmerRemove").hide();
				new JQuery("#newWoodcutterRemove").hide();
				new JQuery("#newMinerRemove").hide();
			case "fire":
				new JQuery("#fire").addClass("disabled");
				new JQuery("#hire").removeClass("disabled");
				new JQuery("#newFarmer").hide();
				new JQuery("#newWoodcutter").hide();
				new JQuery("#newMiner").hide();
				new JQuery("#newFarmerRemove").show();
				new JQuery("#newWoodcutterRemove").show();
				new JQuery("#newMinerRemove").show();
		}
	}
}