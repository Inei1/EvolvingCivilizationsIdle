package upgrades;

import Thx.Decimal;
import Thx.Tuple2;

class ResourceUpgrade extends Buyable{

	public function new(name, id, amount: Decimal, moneyCost: Decimal, foodCost: Decimal, woodCost: Decimal,
	metalCost: Decimal, populationCost: Decimal, populationMaxCost: Decimal, resource){
		super(name, id, amount, moneyCost, foodCost, woodCost, metalCost, populationCost, populationMaxCost);
		this.resource = resource;
	}
	
	private var resource: Resource;
	
	public inline function getResource(): Resource{
		return this.resource;
	}
	
	public override function onClick():Void{
		if (!this.isBuyable()){
			return;
		}
		this.takeResources();
		this.amount++;
		this.resource.updatePlus();
		this.resource.updateBarInc();
		this.increaseCost();
		UpdateUI.updateUpgrade(this);
	}
	
	public function fire(): Void{
		if (this.id == 0 && this.amount > 1){
			this.moneyCost = Math.pow(this.moneyCost, 1 / 1.04);
			this.foodCost = Math.pow(this.foodCost, 1 / 1.04);
			Main.money.amount += this.moneyCost;
			Main.food.amount += this.foodCost;
			this.resource.updatePlus();
			this.amount--;
			Main.population.amount++;
			Main.populationMax.amount++;
			//fix any rounding errors by resetting to base values with only 1 left
			if (this.amount == 1){
				this.moneyCost = 10000;
				this.foodCost = 1000;
			}
			Util.saveGame();
			UpdateUI.updateUpgrade(this);
			UpdateUI.updateResource(this.getResource());
		}
	}
	
	private override function increaseCost(): Void{
		//the precision loss will just have to do for now, I guess. It doesn't even have any noticeable affect, it really only matters for OCD reasons
		this.moneyCost = Math.pow(this.moneyCost, 1.04);
		this.foodCost = Math.pow(this.foodCost, 1.04);
		this.woodCost = Math.pow(this.woodCost, 1.04);
		this.metalCost = Math.pow(this.metalCost, 1.04);
	}
}