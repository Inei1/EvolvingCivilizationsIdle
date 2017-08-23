package upgrades;
import Thx.Decimal;
import js.jquery.JQuery;

//a one time upgrade is bought once, then disappears
class OneTimeUpgrade extends Buyable {
	public function new(name: String, id: Int, ?amount: Decimal, ?moneyCost: Decimal, ?foodCost: Decimal, ?woodCost: Decimal, ?metalCost: Decimal,
	?populationCost: Decimal, ?populationMaxCost: Decimal, ?formalCost: Decimal, ?physicalCost: Decimal, ?lifeCost: Decimal, ?appliedCost: Decimal,
	?socialCost: Decimal, ?electricityCost: Decimal, ?perkCost: Decimal, ?skillCost: Decimal){
		super(name, id, amount, moneyCost, foodCost, woodCost, metalCost, populationCost, populationMaxCost,
		formalCost, physicalCost, lifeCost, appliedCost, socialCost, electricityCost, perkCost, skillCost);
	}
	
	public var bought: Bool = false;
	
	private function modifyHouse(newMax, prevMax){
		Main.house.populationMaxCost = -newMax;
		Main.populationMax.amount = Main.populationMax.amount.add(Main.house.amount.multiply(prevMax)); //increase capacity of existing houses
		new JQuery("#housePopulationIncrease").text(-Main.house.populationMaxCost);
	}
	
	public override function onClick(): Void{
		if (!this.isBuyable()){
			return;
		}
		this.takeResources();
		this.amount++;
		this.increaseCost();
		this.bought = true;
		switch(this.id){
			case 10:
				modifyHouse(4, 2);
			case 11:
				modifyHouse(8, 4);
			case 12:
				modifyHouse(16, 8);
			case 13:
				modifyHouse(32, 16);
			case 14:
				modifyHouse(64, 32);
			case 15:
				modifyHouse(128, 64);
			case 16:
				modifyHouse(256, 128);
			case 17:
				modifyHouse(512, 256);
			case 18:
				modifyHouse(1024, 512);
			case 20:
				Main.food.buildingBonus = 30;
			case 21:
				Main.food.buildingBonus = 60;
			case 22:
				Main.food.buildingBonus = 100;
			case 23:
				Main.food.buildingBonus = 175;
			case 24:
				Main.food.buildingBonus = 300;
			case 25:
				Main.food.buildingBonus = 450;
			case 26:
				Main.food.buildingBonus = 700;
			case 27:
				Main.food.buildingBonus = 1000;
			case 28:
				Main.food.buildingBonus = 1000;
				Main.food.otherBonus *= Math.pow(2, Main.farm.amount);
		}
	}
	
	public function isNextBuyable(): Bool{
		switch(this.id){
			case 10:
				return true;
			case 11:
				//if(Main.evolution == )
				return false;
			default:
				return false;
		}
	}
}