import haxe.Constraints.Constructible;
import js.html.OrientationType;
import js.jquery.JQuery;
import js.Browser;
import js.html.ButtonElement;
import haxe.Json;
import haxe.Timer;

import Thx.Decimal;

import Util;
import Resource;
import upgrades.ResourceUpgrade;
import upgrades.RebuyableUpgrade;
import upgrades.OneTimeUpgrade;

class Main {
	public static var displayLookup = ["", "M", "T", "Qt", "Sp", "No", "Un", "Td", "Qd", "Sd", "Nd", "Uvg", "Tvg", "Qvg"];
	
	public static var moneyTimer = new Timer(1000);
	static var populationTimer = new Timer(10000);
	static var updateUITimer = new Timer(250);
	
	public static var evolution: Int = 0;

	public static var money = new Resource("money", 0, "0", "100", "0");
	public static var food = new Resource("food", 1, "0", "100", "0");
	public static var wood = new Resource("wood", 2, "0", "100", "0");
	public static var metal = new Resource("metal", 3, "0", "100", "0");
	public static var population = new Resource("population", 4, "10", "0", "0");
	public static var populationMax = new Resource("populationMax", 5, "10", "0", "0");
	public static var formal = new Resource("formal", 6, "0", "0", "0");
	public static var physical = new Resource("physical", 7, "0", "0", "0");
	public static var life = new Resource("life", 8, "0", "0", "0");
	public static var applied = new Resource("applied", 9, "0", "0", "0");
	public static var social = new Resource("social", 10, "0", "0", "0");
	public static var electricity = new Resource("electricity", 11, "0", "0", "0");
	public static var skillPoint = new Resource("skillPoints", 12, "0", "0", "0");
	public static var perkPoint = new Resource("perkPoints", 13, "0", "0", "0");
	
	public static var newFarmer = new ResourceUpgrade("newFarmer", 0, "1", "10000", "1000", "0", "0", "1", "1", food);
	public static var farmerUpgrade1 = new ResourceUpgrade("farmerUpgrade1", 1, "0", "10000", "1500", "0", "0", "0", "0", food);
	public static var farmerUpgrade2 = new ResourceUpgrade("farmerUpgrade2", 2, "0", "10000", "0", "1500", "1500", "0", "0", food);
	public static var newWoodcutter = new ResourceUpgrade("newWoodcutter", 0, "1", "10000", "1000", "0", "0", "1", "1", wood);
	public static var woodcutterUpgrade1 = new ResourceUpgrade("woodcutterUpgrade1", 1, "0", "10000", "1500", "0", "0", "0", "0", wood);
	public static var woodcutterUpgrade2 = new ResourceUpgrade("woodcutterUpgrade2", 2, "0", "10000", "0", "1500", "1500", "0", "0", wood);
	public static var newMiner = new ResourceUpgrade("newMiner", 0, "1", "10000", "1000", "0", "0", "1", "1", metal);
	public static var minerUpgrade1 = new ResourceUpgrade("minerUpgrade1", 1, "0", "10000", "1500", "0", "0", "0", "0", metal);
	public static var minerUpgrade2 = new ResourceUpgrade("minerUpgrade2", 2, "0", "10000", "0", "1500", "1500", "0", "0", metal);
	
	public static var house = new RebuyableUpgrade("house", 0, building, "0", "5000", "250", "1000", "1000", "0", "-2");
	public static var farm = new RebuyableUpgrade("farm", 1, building, "0", "20000", "8000", "5000", "2000");
	public static var lumberMill = new RebuyableUpgrade("lumberMill", 2, building, "0", "20000", "2000", "8000", "5000");
	public static var metalMine = new RebuyableUpgrade("metalMine", 3, building, "0", "20000", "2000", "5000", "8000");
	public static var taxCollector = new RebuyableUpgrade("tax", 4, building, "0", "2500", "100", "1500", "1500");
	public static var goldMine = new RebuyableUpgrade("goldMine", 5, building, "0", "10000", "500", "5000", "5000");
	public static var cropHarvester = new RebuyableUpgrade("cropHarvester", 6, building);
	public static var woodHarvester = new RebuyableUpgrade("woodHarvester", 7, building);
	public static var metalHarvester = new RebuyableUpgrade("metalHarvester", 8, building);
	public static var gatheringSchool = new RebuyableUpgrade("gatheringSchool", 9, building);
	public static var toolForge = new RebuyableUpgrade("toolForge", 10, building);
	public static var woodBurner = new RebuyableUpgrade("woodBurner", 11, building);
	public static var electrostaticGenerator = new RebuyableUpgrade("electrostaticGenerator", 12, building);
	public static var solarPanel = new RebuyableUpgrade("solarPanel", 13, building);
	public static var nuclearGenerator = new RebuyableUpgrade("nuclearGenerator", 14, building);
	public static var newFormal = new RebuyableUpgrade("newFormal", 100, research, "0", "10000", "1000", "0", "0", "1", "1");
	public static var newPhysical = new RebuyableUpgrade("newPhysical", 101, research, "0", "10000", "1000", "0", "0", "1", "1");
	public static var newLife = new RebuyableUpgrade("newLife", 102, research, "0", "10000", "1000", "0", "0", "1", "1");
	public static var newApplied = new RebuyableUpgrade("newApplied", 103, research, "0", "10000", "1000", "0", "0", "1", "1");
	public static var newSocial = new RebuyableUpgrade("newSocial", 104, research, "0", "10000", "1000", "0", "0", "1", "1");
	public static var formalTheory = new RebuyableUpgrade("formalTheory", 105, research, "0", "0", "0", "0", "0", "0", "0", "10");
	public static var physicalTheory = new RebuyableUpgrade("physicalTheory", 106, research, "0", "0", "0", "0", "0", "0", "0", "4", "6");
	public static var lifeTheory = new RebuyableUpgrade("lifeTheory", 107, research, "0", "0", "0", "0", "0", "0", "0", "2", "2", "6");
	public static var appliedTheory = new RebuyableUpgrade("appliedTheory", 108, research, "0", "0", "0", "0", "0", "0", "0", "3", "0", "0", "7");
	public static var socialTheory = new RebuyableUpgrade("socialTheory", 109, research, "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "10");
	public static var breakthrough = new RebuyableUpgrade("breakthroughResearch", 110, research);
	public static var upgradeCost = new RebuyableUpgrade("upgradeCostResearch", 111, research);
	
	//public static var evolution1 = new OneTimeUpgrade("evolution1", 0, "0", "10000000", "1000000", "1000000", "1000000", "10", "0");
	//public static var evolution2 = new OneTimeUpgrade("evolution2", 1, "0", "15848931924", "3981071705", "3981071705", "3981071705", "100", "0", "100000", "100000", "100000", "100000", "100000");
	//public static var evolution3 = new OneTimeUpgrade("researchLab3", 2, "0", "20892961307251382", "2290867652275221", "2290867652275221", "2290867652275221", "1000", "0", "100000000", "100000000", "100000000", "100000000", "100000000", "100000");
	//public static var evolution4 = new OneTimeUpgrade("researchLab4", 3);
	//public static var evolution5 = new OneTimeUpgrade("researchLab5", 4);
	public static var house2 = new OneTimeUpgrade("house2Research", 10, "0", "10000000", "1000000", "5000000", "5000000", "0", "0", "200", "1000", "200", "500", "400");
	public static var house3 = new OneTimeUpgrade("house3Research", 11, "0", "562341325", "31622776", "511282591", "511282591", "0", "0", "2170", "63095", "2170", "11180", "8000");
	public static var house4 = new OneTimeUpgrade("house4Research", 12, "0", "86596432336", "371373649", "209536317447", "209536317447", "0", "0", "68851", "47862117", "68851", "1182123", "715541");
	public static var house5 = new OneTimeUpgrade("house5Research", 13, "0", "46975888167064", "523299099124", "521959851769234", "521959851769234", "0", "0", "10350703", "1940827988668", "10350703", "1285268905", "605273674", "10000");
	public static var farm2 = new OneTimeUpgrade("farm2Research", 20, "0", "10000000", "1000000", "1000000", "1000000", "0", "0", "200", "0", "2000", "500", "0");
	public static var farm3 = new OneTimeUpgrade("farm3Research", 21, "0", "562341325", "6309573444", "31622776", "31622776", "0", "0", "2170", "0", "191270", "11180", "0");
	public static var farm4 = new OneTimeUpgrade("farm4Research", 22, "0", "86596432336", "52480746024977", "2371373705", "2371373705", "0", "0", "68851", "0", "282251844", "1182123", "0");
	public static var farm5 = new OneTimeUpgrade("farm5Research", 23, "0", "46975888167064", "16143585568264862654", "523299114681", "523299114681", "0", "0", "10350703", "0", "33190887267647", "1285268905", "0", "10000");
	public static var lumberMill2 = new OneTimeUpgrade("lumberMill2Research", 30, "0", "10000000", "1000000", "10000000", "1000000", "0", "0", "400", "500", "400", "1000", "0");
	public static var lumberMill3 = new OneTimeUpgrade("lumberMill3Research", 31, "0", "562341325", "31622776", "6309573444", "31622776", "0", "0", "8000", "11180", "8000", "63095", "0");
	public static var lumberMill4 = new OneTimeUpgrade("lumberMill4Research", 32, "0", "86596432336", "2371373705", "52480746024977", "2371373705", "0", "0", "715541", "1182177", "715541", "47862117", "0");
	public static var lumberMill5 = new OneTimeUpgrade("lumberMill5Research", 33, "0", "46975888167064", "523299114681", "16143585568264750798", "523299114681", "0", "0", "605274629", "1285356992", "605274629", "1940827988668", "0", "10000");
	public static var metalMine2 = new OneTimeUpgrade("metalMine2Research", 40, "0", "10000000", "1000000", "1000000", "10000000", "0", "0", "700", "1000", "0", "700", "0");
	public static var metalMine3 = new OneTimeUpgrade("metalMine3Research", 41, "0", "562341325", "31622776", "31622776", "6309573444", "0", "0", "18520", "63095", "0", "18520", "0");
	public static var metalMine4 = new OneTimeUpgrade("metalMine4Research", 42, "0", "86596432336", "2371373705", "2371373705", "52480746024977", "0", "0", "25204068", "47863009", "0", "25204068", "0");
	public static var metalMine5 = new OneTimeUpgrade("metalMine5Research", 43, "0", "46975888167064", "523299114681", "523299114681", "16143585568264750798", "0", "0", "4001343956", "1940885877592", "0", "4001343956", "0", "10000");
	public static var goldMine2 = new OneTimeUpgrade("goldMine2Research", 50, "0", "100000000", "1000000", "1000000", "5000000", "0", "0", "700", "7000", "1000", "0", "0");
	public static var goldMine3 = new OneTimeUpgrade("goldMine3Research", 51, "0", "158489319246", "31622776", "31622776", "511282591", "0", "0", "18520", "18520", "63095", "0", "0");
	public static var goldMine4 = new OneTimeUpgrade("goldMine4Research", 52, "0", "4786300923226383", "2371373705", "2371373705", "209536317597", "0", "0", "2520406", "2520406", "47863009", "0", "0");
	public static var goldMine5 = new OneTimeUpgrade("goldMine5Research", 53, "0", "8953647655495938230728", "523299114681", "523299114681", "521959852255398", "0", "0", "4001343956", "4001343956", "1940885877592", "0", "0", "10000");
	public static var taxCollector2 = new OneTimeUpgrade("taxCollector2Research", 60, "0", "500000000", "1000000", "1000000", "1000000", "0", "0", "0", "0", "0", "0", "5000");
	public static var taxCollector3 = new OneTimeUpgrade("taxCollector3Research", 61, "0", "1508544084136", "31622776", "31622776", "31622776", "0", "0", "0", "0", "0", "0", "828613");
	public static var taxCollector4 = new OneTimeUpgrade("taxCollector4Research", 62, "0", "112196990670098650", "2371373705", "2371373705", "2371373705", "0", "0", "0", "0", "0", "0", "2946885155");
	public static var taxCollector5 = new OneTimeUpgrade("taxCollector5Research", 63, "0", "741265336574877906877972", "523299114681", "523299114681", "523299114681", "0", "0", "0", "0", "0", "0", "1415732290661702");
	
	public static var cropHarvesterResearch = new OneTimeUpgrade("cropHarvesterResearch", 70, "0", "10000000", "1000000", "5000000", "5000000", "0", "0", "200", "1000", "200", "500", "400");
	public static var woodHarvesterResearch = new OneTimeUpgrade("woodHarvesterResearch", 71, "0", "10000000", "1000000", "5000000", "5000000", "0", "0", "200", "1000", "200", "500", "400");
	public static var metalHarvesterResearch = new OneTimeUpgrade("metalHarvesterResearch", 72, "0", "10000000", "1000000", "5000000", "5000000", "0", "0", "200", "1000", "200", "500", "400");
	public static var gatheringSchoolResearch = new OneTimeUpgrade("gatheringSchoolResearch", 73, "0", "10000000", "1000000", "5000000", "5000000", "0", "0", "200", "1000", "200", "500", "400");
	public static var toolForgeResearch = new OneTimeUpgrade("toolForgeResearch", 74, "0", "10000000", "1000000", "5000000", "5000000", "0", "0", "200", "1000", "200", "500", "400");
	public static var electricityResearch = new OneTimeUpgrade("electricityResearch", 75, "0", "100000000000000", "10000000000000", "10000000000000", "10000000000000", "0", "0", "1000000", "5000000", "0", "3000000", "0");
	
	public static var resourceArray = [money, food, wood, metal, population, populationMax];
	public static var upgradeArray = [newFarmer, farmerUpgrade1, farmerUpgrade2, newWoodcutter, woodcutterUpgrade1, woodcutterUpgrade2, newMiner, minerUpgrade1, minerUpgrade2];
	public static var buildingArray = [house, farm, lumberMill, metalMine, taxCollector, goldMine, cropHarvester, woodHarvester, metalHarvester, gatheringSchool, toolForge, woodBurner, electrostaticGenerator, solarPanel, nuclearGenerator];
	public static var researchArray = [newFormal, newPhysical, newLife, newApplied, newSocial, formalTheory, physicalTheory, lifeTheory, appliedTheory, socialTheory, house2, house3, house4, house5, farm2, farm3, farm4, farm5, lumberMill2, lumberMill3, lumberMill4, lumberMill5, metalMine2, metalMine3, metalMine4, metalMine5, goldMine2, goldMine3, goldMine4, goldMine5, taxCollector2, taxCollector3, taxCollector4, taxCollector5, cropHarvesterResearch, woodHarvesterResearch, metalHarvesterResearch, gatheringSchoolResearch, toolForgeResearch, electricityResearch, breakthrough, upgradeCost];
	
	public static var upgradeAmountMult: Decimal = 1.1;
	public static var upgradeSpeedMult: Decimal = 1.1;
	
	public static inline var PERKPAGEBUTTONS: Int = 8;
	
	static function main(){
		//uncomment to delete local storage
		//Browser.getLocalStorage().clear();
		food.setupBar(); wood.setupBar();
		Browser.document.getElementById("evolveButton").onclick = Util.dialogs.bind("evolve");
		Browser.document.getElementById("evolutionButton").onclick = Main.evolve;
		Browser.document.getElementById("saveButton").onclick = Util.saveGame;
		Browser.document.getElementById("resourcesButton").onclick = Util.getResources;
		//Browser.document.getElementById("deleteButton").onclick = untyped __js__('function(){localStorage.clear(); alert("deleted");}'); <-- does not work
		Browser.document.getElementById("achievementsButton").onclick = Util.dialogs.bind("achievements");
		Browser.document.getElementById("optionsButton").onclick = Util.dialogs.bind("options");
		Browser.document.getElementById("resetButton").onclick = Util.dialogs.bind("reset1");
		Browser.document.getElementById("skillsButton").onclick = Util.dialogs.bind("skills", 900, 600);
		Browser.document.getElementById("skillsBadge").onclick = Util.dialogs.bind("skills", 900, 600);
		Browser.document.getElementById("hire").onclick = UpdateUI.hireFire.bind("hire");
		Browser.document.getElementById("fire").onclick = UpdateUI.hireFire.bind("fire");
		Browser.document.getElementById("constructionButton").onclick = Util.dialogs.bind("construction1");
		Browser.document.getElementById("researchButton").onclick = Util.dialogs.bind("research1");
		Browser.document.getElementById("researchProductionOverview").onclick = Util.dialogs.bind("researchProd");
		Browser.document.getElementById("manufacturingComponentsButton").onclick = Util.dialogs.bind("components1");
		Browser.document.getElementById("manufacturingUpgradesButton").onclick = Util.dialogs.bind("upgrades1");
		
		for (i in resourceArray.slice(1, 4)){
			Browser.document.getElementById(i.getName() + "ProdButton").onclick = Util.dialogs.bind(i.getName() + "Prod");
		}
		
		for (i in upgradeArray){
			Browser.document.getElementById(i.getName()).onclick = i.onClick;
			if (i.getId() == 0){
				Browser.document.getElementById(i.getName() + "Remove").onclick = i.fire;
			}
		}
		
		for (i in buildingArray){
			Browser.document.getElementById(i.getName() + "Button").onclick = i.onClick;
		}
		
		for (i in researchArray){
			Browser.document.getElementById(i.getName() + "Button").onclick = i.onClick;
		}
		
		for (i in 2...PERKPAGEBUTTONS){
			Browser.document.getElementById("resetP" + i).onclick = (i % 2 == 0) ? Util.changePage.bind("reset", Std.int((i/2)+1), Std.int(i/2)) : Util.changePage.bind("reset", Std.int((i/2)-0.5), Std.int((i/2)+0.5));
		}
		
		Browser.document.addEventListener("visibilitychange", Util.addOfflineProduction);
		
		//save the game when exiting or changing tabs
		Browser.document.addEventListener("beforeunload", Util.saveGame);
		
		if (Browser.getLocalStorage().getItem("foodAmount") == null){
			trace("new game");
			UpdateUI.updateAll();
		} else {
			trace("load game");
			Util.loadGame();
			UpdateUI.displayUI(evolution);
			Util.addOfflineProduction();
			UpdateUI.updateAll();
		}
		updateUITimer.run = UpdateUI.updateAll;
	}
	
	public static inline function getMoneyGain(): Decimal{
		return population.amount * money.plus;
	}
	
	public static function addMoney(): Void{
		money.amount += getMoneyGain();
		UpdateUI.updateResource(money);
	}
	
	static function addPopulation(): Void{
		if (populationMax.amount > population.amount){
			population.amount++;
			food.autoCost += 10;
		}
	}
	
	static function evolve(): Void{
		if (evolution == 0 && food.amount >= 2000 && wood.amount >= 2000){
			evolution++;
			UpdateUI.displayUI(evolution);
		} else if (evolution == 1 && food.amount >= "10000" && wood.amount >= "25000" && metal.amount >= "15000" && farmerUpgrade1.amount >= "2"
			&& woodcutterUpgrade1.amount >= "2" && minerUpgrade1.amount >= "2"){
			evolution++;
			UpdateUI.displayUI(evolution);
		} else if (evolution == 2 && food.amount >= "500000" && wood.amount >= "500000" && metal.amount >= "500000" && population.amount >= "20"
			&& newFarmer.amount >= "5" && farmerUpgrade1.amount >= "5" && farmerUpgrade2.amount >= "5" && newWoodcutter.amount >= "5"
			&& woodcutterUpgrade1.amount >= "5" && woodcutterUpgrade2.amount >= "5" && newMiner.amount >= "5" && minerUpgrade1.amount >= "5"
			&& minerUpgrade2.amount >= "5"){
			evolution++;
			UpdateUI.displayUI(evolution);
		}
	}
}