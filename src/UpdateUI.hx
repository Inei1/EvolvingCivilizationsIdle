import js.jquery.JQuery;
import upgrades.OneTimeUpgrade;
import upgrades.RebuyableUpgrade;
import upgrades.ResourceUpgrade;

class UpdateUI {
	
	public static function updateAll(): Void{
		updateAllResources();
		updateAllResourceUpgrades();
		updateAllBuildingUpgrades();
		updateAllResearchUpgrades();
		displayEvolveButton();
	}
	
	public static function updateAllResources(): Void{
		for (i in Main.resourceArray){
			updateResource(i);
		}
	}
	
	public static function updateResource(resource: Resource): Void{
		new JQuery("#" + resource.getName() + "Amount").text(resource.format());
		new JQuery("#" + resource.getName() + "Second").text(Util.formatDecimal((resource.plus - resource.autoCost).multiply(
			(resource.getUpgrades()[1] != null) ? Math.pow(Main.upgradeAmountMult, resource.getUpgrades()[2].amount) : 1)));
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
	
	public static function updateAllBuildingUpgrades(){
		for (i in Main.buildingArray){
			updateUpgrade(i);
		}
	}
	
	public static function updateAllResearchUpgrades(){
		for (i in Main.researchArray){
			updateUpgrade(i);
		}
	}
	
	public static function updateUpgrade(upgrade: Dynamic){
		new JQuery("#" + upgrade.getName() + "Count").text(upgrade.amount);
		new JQuery("#" + upgrade.getName() + "Money").text(upgrade.format("money"));
		new JQuery("#" + upgrade.getName() + "Food").text(upgrade.format("food"));
		new JQuery("#" + upgrade.getName() + "Wood").text(upgrade.format("wood"));
		new JQuery("#" + upgrade.getName() + "Metal").text(upgrade.format("metal"));
		new JQuery("#" + upgrade.getName() + "Formal").text(upgrade.format("formal"));
		new JQuery("#" + upgrade.getName() + "Physical").text(upgrade.format("physical"));
		new JQuery("#" + upgrade.getName() + "Life").text(upgrade.format("life"));
		new JQuery("#" + upgrade.getName() + "Applied").text(upgrade.format("applied"));
		new JQuery("#" + upgrade.getName() + "Social").text(upgrade.format("social"));
		new JQuery("#" + upgrade.getName() + "Electricity").text(upgrade.format("electricity"));
		new JQuery("#" + upgrade.getName() + "Perk").text(upgrade.format("perkPoint"));
		new JQuery("#" + upgrade.getName() + "Skill").text(upgrade.format("skillPoint"));
		updateUpgradeButton(upgrade);
	}
	
	public static function updateUpgradeButton(upgrade: Dynamic){
		if(upgrade.isBuyable()){
			new JQuery("#" + upgrade.getName() + "Button").removeClass("disabled");
		} else {
			new JQuery("#" + upgrade.getName() + "Button").addClass("disabled");
		}
	}
	
	public static function displayUI(evolution: Int){
		if (Main.skill40.amount >= 1){
			new JQuery("#marketButton").removeClass("hidden");
		}
		if (evolution >= 0){ //unlocked by default
			Main.food.setupBar();
			Main.wood.setupBar();
		}
		if (evolution >= 1){ //unlocked by stone age: neolithic period
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
		if (evolution >= 2){ //unlocked by bronze age
			new JQuery("#foodUpgrade1").removeClass("hidden");
			new JQuery("#woodUpgrade1").removeClass("hidden");
			new JQuery("#metalUpgrade1").removeClass("hidden");
			new JQuery("#foodUpgrade3").removeClass("hidden");
			new JQuery("#woodUpgrade3").removeClass("hidden");
			new JQuery("#metalUpgrade3").removeClass("hidden");
			new JQuery("#construction").removeClass("hidden");
			new JQuery("#house").removeClass("hidden");
			new JQuery("#tax").removeClass("hidden");
			new JQuery("#evolution2").addClass("hidden");
			new JQuery("#evolution3").removeClass("hidden");
		}
		if (evolution >= 3){ //unlocked by iron age
			new JQuery("#farm").removeClass("hidden");
			new JQuery("#lumberMill").removeClass("hidden");
			new JQuery("#metalMine").removeClass("hidden");
			new JQuery("#goldMine").removeClass("hidden");
			new JQuery("#skills").removeClass("hidden");
			new JQuery("#evolution3").addClass("hidden");
			new JQuery("#evolution4").removeClass("hidden");
		}
		if (evolution >= 4){ //unlocked by classical age
			new JQuery("#research").removeClass("hidden");
			//the basic research buttons are visible by default
			new JQuery("#house2Research").removeClass("hidden");
			new JQuery("#farm2Research").removeClass("hidden");
			new JQuery("#lumberMill2Research").removeClass("hidden");
			new JQuery("#metalMine2Research").removeClass("hidden");
			new JQuery("#goldMine2Research").removeClass("hidden");
			new JQuery("#taxCollector2Research").removeClass("hidden");
			//up to building 3 of each is available in this age
		}
		if (evolution >= 5){ //unlocked by middle ages
			new JQuery("#reset").removeClass("hidden");
			new JQuery("#inspectorResearch").removeClass("hidden");
			new JQuery("#gatheringSchoolResearch").removeClass("hidden");
			new JQuery("#toolForgeResearch").removeClass("hidden");
			new JQuery("#cropHarvesterResearch").removeClass("hidden");
			new JQuery("#woodHarvesterResearch").removeClass("hidden");
			new JQuery("#metalHarvesterResearch").removeClass("hidden");
			//up to building 5 is available
		}
		if (evolution >= 6){ //unlocked by early modern period
			new JQuery("#manufacturingResearch").removeClass("hidden");
			//up to building 7 is available
		}
		if (evolution >= 7){ //unlocked by machine age
			new JQuery("#electricityResearch").removeClass("hidden");
			new JQuery("#upgradeCostResearch").removeClass("hidden");
			new JQuery("#breakthroughResearch").removeClass("hidden");
			//TODO include research for manufacturing involving electricity, more manufacturing
			
			//up to building 9 is available
		}
		if (evolution >= 8){ //unlocked by information age
			new JQuery("#singularityGenerationResearch").removeClass("hidden");
			new JQuery("#roboticsFactoryResearch").removeClass("hidden");
			new JQuery("#internetResearch").removeClass("hidden");
			//TODO manufacturing research from the internet, building that gives massive amounts of money (e-commerce),
			//more manufacturing make the internet grant massive boosts to all production
			
			//up to building 10 is available
		}
	}
	
	public static function displayEvolveButton(){
		if (Main.checkEvolveRequirements()){
			new JQuery("#evolutionButton").removeClass("disabled");
		} else {
			new JQuery("#evolutionButton").addClass("disabled");
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
	
	public static function updateAllSkills(){
		
	}
	
	public static function updateSkill(){
		
	}
}