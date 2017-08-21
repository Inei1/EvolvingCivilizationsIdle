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
	
	public override function onClick(){
		if (!this.isBuyable()){
			return;
		}
		this.takeResources();
		this.amount++;
		this.increaseCost();
		this.bought = true;
		switch(this.id){
			case 0:
			case 10:
				Main.house.populationMaxCost = -5;
				Main.populationMax.amount = Main.populationMax.amount.add(Main.house.amount.multiply(3)); //increase capacity of existing houses
				new JQuery("#housePopulationIncrease").text(-Main.house.populationMaxCost);
			case 11:
				Main.house.populationMaxCost = -10;
				Main.populationMax.amount = Main.populationMax.amount.add(Main.house.amount.multiply(5)); //increase capacity of existing houses
				new JQuery("#housePopulationIncrease").text(-Main.house.populationMaxCost);
			case 12:
				Main.house.populationMaxCost = -25;
				Main.populationMax.amount = Main.populationMax.amount.add(Main.house.amount.multiply(15)); //increase capacity of existing houses
				new JQuery("#housePopulationIncrease").text(-Main.house.populationMaxCost);
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