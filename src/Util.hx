import js.Browser;
import haxe.Json;
import js.html.ButtonElement;
import js.html.Exception;
import js.html.VisibilityState;
import js.jquery.JQuery;

import Thx.Decimal;

class Util {
	
	public static function saveGame(): Void{
		if (Browser.getLocalStorage() == null){
			trace("Local Storage is not supported, please switch to a supporting browser, such as chrome, firefox, edge, or internet explorer to enable saving.");
		}
		
		Browser.getLocalStorage().setItem("evolution", Std.string(Main.evolution));
		Browser.getLocalStorage().setItem("upgradeAmountMult", Main.upgradeAmountMult.toString());
		Browser.getLocalStorage().setItem("upgradeSpeedMult", Main.upgradeSpeedMult.toString());
		Browser.getLocalStorage().setItem("marketBuy", Std.string(Main.marketBuy));
		Browser.getLocalStorage().setItem("marketSell", Std.string(Main.marketSell));
		
		//localStorage does not play nice with classes in haxe, so each Decimal must be seperate from everything else
		//barinc and progress can be determined at runtime, id and name are constant, so they do not need to be saved
		for (i in Main.resourceArray){
			Browser.getLocalStorage().setItem(i.getName() + "Amount", i.amount.toString());
			Browser.getLocalStorage().setItem(i.getName() + "Plus", i.plus.toString());
			Browser.getLocalStorage().setItem(i.getName() + "AutoCost", i.autoCost.toString());
			if (i.buildingBonus != null) Browser.getLocalStorage().setItem(i.getName() + "BuildingBonus", Std.string(i.buildingBonus));
		}
		for (i in Main.upgradeArray){
			Browser.getLocalStorage().setItem(i.getName() + "Amount", i.amount.toString());
			Browser.getLocalStorage().setItem(i.getName() + "Money", i.moneyCost.toString());
			Browser.getLocalStorage().setItem(i.getName() + "Food", i.foodCost.toString());
			Browser.getLocalStorage().setItem(i.getName() + "Wood", i.woodCost.toString());
			Browser.getLocalStorage().setItem(i.getName() + "Metal", i.metalCost.toString());
		}
		for (i in Main.buildingArray){
			if(i.amount != null) Browser.getLocalStorage().setItem(i.getName() + "Amount", i.amount.toString());
			if(i.moneyCost != null) Browser.getLocalStorage().setItem(i.getName() + "Money", i.moneyCost.toString());
			if(i.foodCost != null) Browser.getLocalStorage().setItem(i.getName() + "Food", i.foodCost.toString());
			if(i.woodCost != null) Browser.getLocalStorage().setItem(i.getName() + "Wood", i.woodCost.toString());
			if(i.metalCost != null) Browser.getLocalStorage().setItem(i.getName() + "Metal", i.metalCost.toString());
			if(i.electricityCost != null) Browser.getLocalStorage().setItem(i.getName() + "Electricity", i.electricityCost.toString());
		}
		for (i in Main.researchArray){
			if(i.amount != null) Browser.getLocalStorage().setItem(i.getName() + "Amount", i.amount.toString());
			if(i.moneyCost != null) Browser.getLocalStorage().setItem(i.getName() + "Money", i.moneyCost.toString());
			if(i.foodCost != null) Browser.getLocalStorage().setItem(i.getName() + "Food", i.foodCost.toString());
			if(i.woodCost != null) Browser.getLocalStorage().setItem(i.getName() + "Wood", i.woodCost.toString());
			if(i.metalCost != null) Browser.getLocalStorage().setItem(i.getName() + "Metal", i.metalCost.toString());
			if(i.electricityCost != null) Browser.getLocalStorage().setItem(i.getName() + "Electricity", i.electricityCost.toString());
			if(i.formalCost != null) Browser.getLocalStorage().setItem(i.getName() + "Formal", i.formalCost.toString());
			if(i.physicalCost != null) Browser.getLocalStorage().setItem(i.getName() + "Physical", i.physicalCost.toString());
			if(i.lifeCost != null) Browser.getLocalStorage().setItem(i.getName() + "Life", i.lifeCost.toString());
			if(i.appliedCost != null) Browser.getLocalStorage().setItem(i.getName() + "Applied", i.appliedCost.toString());
			if(i.socialCost != null) Browser.getLocalStorage().setItem(i.getName() + "Social", i.socialCost.toString());
		}
	}
	
	public static function loadGame(): Void{
		Main.evolution = Std.parseInt(Browser.getLocalStorage().getItem("evolution"));
		Main.upgradeAmountMult = Decimal.fromString(Browser.getLocalStorage().getItem("upgradeAmountMult"));
		Main.upgradeSpeedMult = Decimal.fromString(Browser.getLocalStorage().getItem("upgradeSpeedMult"));
		Main.marketBuy = Std.parseFloat(Browser.getLocalStorage().getItem("marketBuy"));
		Main.marketSell = Std.parseFloat(Browser.getLocalStorage().getItem("marketSell"));
		for (i in Main.resourceArray){
			i.amount = Browser.getLocalStorage().getItem(i.getName() + "Amount");
			i.plus = Browser.getLocalStorage().getItem(i.getName() + "Plus");
			i.autoCost = Browser.getLocalStorage().getItem(i.getName() + "AutoCost");
			if (i.buildingBonus != null) i.buildingBonus = Std.parseInt(Browser.getLocalStorage().getItem(i.getName() + "BuildingBonus"));
		}
		for (i in Main.upgradeArray){
			i.amount = Browser.getLocalStorage().getItem(i.getName() + "Amount");
			i.moneyCost = Browser.getLocalStorage().getItem(i.getName() + "Money");
			i.foodCost = Browser.getLocalStorage().getItem(i.getName() + "Food");
			i.woodCost = Browser.getLocalStorage().getItem(i.getName() + "Wood");
			i.metalCost = Browser.getLocalStorage().getItem(i.getName() + "Metal");
		}
		for (i in Main.buildingArray){
			if(i.amount != null) i.amount = Browser.getLocalStorage().getItem(i.getName() + "Amount");
			if(i.moneyCost != null) i.moneyCost = Browser.getLocalStorage().getItem(i.getName() + "Money");
			if(i.foodCost != null) i.foodCost = Browser.getLocalStorage().getItem(i.getName() + "Food");
			if(i.woodCost != null) i.woodCost = Browser.getLocalStorage().getItem(i.getName() + "Wood");
			if(i.metalCost != null) i.metalCost = Browser.getLocalStorage().getItem(i.getName() + "Metal");
			if(i.electricityCost != null) i.electricityCost = Browser.getLocalStorage().getItem(i.getName() + "Electricity");
		}
		for (i in Main.researchArray){
			if(i.amount != null) i.amount = Browser.getLocalStorage().getItem(i.getName() + "Amount");
			if(i.moneyCost != null) i.moneyCost = Browser.getLocalStorage().getItem(i.getName() + "Money");
			if(i.foodCost != null) i.foodCost = Browser.getLocalStorage().getItem(i.getName() + "Food");
			if(i.woodCost != null) i.woodCost = Browser.getLocalStorage().getItem(i.getName() + "Wood");
			if(i.metalCost != null) i.metalCost = Browser.getLocalStorage().getItem(i.getName() + "Metal");
			if(i.electricityCost != null) i.electricityCost = Browser.getLocalStorage().getItem(i.getName() + "Electricity");
			if (i.formalCost != null) i.formalCost = Browser.getLocalStorage().getItem(i.getName() + "Formal");
			if(i.physicalCost != null) i.physicalCost = Browser.getLocalStorage().getItem(i.getName() + "Physical");
			if(i.lifeCost != null) i.lifeCost = Browser.getLocalStorage().getItem(i.getName() + "Life");
			if(i.appliedCost != null) i.appliedCost = Browser.getLocalStorage().getItem(i.getName() + "Applied");
			if(i.socialCost != null) i.socialCost = Browser.getLocalStorage().getItem(i.getName() + "Social");
		}
	}
	
	public static function deleteGame(): Void{
		Browser.getLocalStorage().clear();
		Browser.alert("deleted");
	}
	
	public static function getResources(): Void{
		Main.money.amount += "1000000000000000000000";
		Main.food.amount += "100000000000000000000";
		Main.wood.amount += "100000000000000000000";
		Main.metal.amount += "100000000000000000000";
		Main.population.amount += "10000000000";
		Main.populationMax.amount += "10000000000";
		UpdateUI.updateAll();
	}
	
	//use js code injection with jquery ui to open dialogs
	public static function dialogs(dialog: String, width: Int=350, height: Dynamic="auto", ?buttons: Array<ButtonElement>): Void{
		untyped __js__('$(function(){$("#" + dialog).dialog({closeText: "", width: width, height: height}).dialog("open").removeClass("hidden");});');
	}
	
	public static function closeDialog(dialog: String): Void{
		untyped __js__('$("#" + dialog).dialog("close")');
	}
	
	public static function changePage(name: String, page: Int, prev: Int): Void{
		untyped __js__('$("#" + name + page).removeClass("hidden");$("#" + name + page).dialog();$("#" + name + prev).dialog("close");');
	}
	
	public static function formatDecimal(number: Decimal): String{
		if (number == null){
			return "0";
		}
		var suffix = 0;
		while (number >= 1000000){
			suffix++;
			number /= 1000000;
		}
		if (suffix == 0){
			return number.round().toString();
		}
		return number.roundTo(2).toString() + Main.displayLookup[suffix];
	}
	
	public static inline function isUndefined(value : Dynamic): Bool{
		return untyped __js__('"undefined" === typeof value');
	}

	
	public static function addOfflineProduction(){
		if (Browser.document.visibilityState == VisibilityState.HIDDEN){
			Browser.getLocalStorage().setItem("time", Std.string(Date.now().getTime()));
			return;
		}
		var oldTime: Float = Std.parseFloat(Browser.getLocalStorage().getItem("time"));
		var newTime: Float = Date.now().getTime();
		//fun fact: this int will overflow if someone comes back to the game after 69 years
		var secondsPassed: Int = Math.floor((newTime - oldTime) / 1000);
		trace("time passed: " + secondsPassed);
		if (Math.isNaN(secondsPassed)){
			trace("ERROR: seconds passed is NaN!!");
			return;
		}
		Main.money.amount += getOfflineProduction(Main.money, secondsPassed);
		Main.food.amount += getOfflineProduction(Main.food, secondsPassed);
		Main.wood.amount += getOfflineProduction(Main.wood, secondsPassed);
        Main.metal.amount += getOfflineProduction(Main.metal, secondsPassed);
        Main.electricity.amount += getOfflineProduction(Main.electricity, secondsPassed);
        Main.formal.amount += getOfflineProduction(Main.formal, secondsPassed);
        Main.physical.amount += getOfflineProduction(Main.physical, secondsPassed);
        Main.life.amount += getOfflineProduction(Main.life, secondsPassed);
        Main.applied.amount += getOfflineProduction(Main.applied, secondsPassed);
        Main.social.amount += getOfflineProduction(Main.social, secondsPassed);
	}
	
	//calling the functions that add resources in a loop will cause the game to freeze, so this has to be seperate
	private static function getOfflineProduction(resource: Resource, seconds: Int): Decimal{
		if (resource == null){
			return Decimal.zero;
		}
		if(resource == Main.money){
			return Main.getMoneyGain().multiply(seconds);
		} else if(resource == Main.food || resource == Main.wood || resource == Main.metal){
			return resource.getResourceAdd().multiply(seconds).divide(10);
		} else if (resource == Main.population || resource == Main.populationMax){
			return Decimal.zero;
		} else {
        return resource.plus.multiply(seconds);
		}
	}
	
	public static function reset(){
		//TODO reset
	}
	
	public static function removeResources(){
		Main.money.amount = 0;
		Main.food.amount = 0;
		Main.wood.amount = 0;
		Main.metal.amount = 0;
		Main.population.amount = 10;
		Main.populationMax.amount = 10;
	}
	
	public static inline var MAXSKILLID = 61;
	public static function drawSkills(){
		for (i in 0...MAXSKILLID){
			
		}
	}
}