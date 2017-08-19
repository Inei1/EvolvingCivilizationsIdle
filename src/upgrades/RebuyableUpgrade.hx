package upgrades;
import Thx.Decimal;

enum UpgradeType{
	building;
	research;
	skill;
	perk;
}

//a rebuyable upgrade can be bought an indefinite amount of times
class RebuyableUpgrade extends Buyable {
	public function new(name: String, id: Int, type: UpgradeType, ?amount: Decimal, ?moneyCost: Decimal, ?foodCost: Decimal, ?woodCost: Decimal, ?metalCost: Decimal,
	?populationCost: Decimal, ?populationMaxCost: Decimal, ?formalCost: Decimal, ?physicalCost: Decimal, ?lifeCost: Decimal, ?appliedCost: Decimal,
	?socialCost: Decimal, ?electricityCost: Decimal, ?perkCost: Decimal, ?skillCost: Decimal){
		super(name, id, amount, moneyCost, foodCost, woodCost, metalCost, populationCost, populationMaxCost, formalCost,
			physicalCost, lifeCost, appliedCost, socialCost, electricityCost, perkCost, skillCost);
		this.type = type;
	}
	
	private var type: UpgradeType;
	
	public override function onClick(){
		if (!this.isBuyable()){
			return;
		}
		this.takeResources();
		this.amount++;
		this.increaseCost();
		switch(this.id){
			case 0:
				//nothing
			case 1:
				Main.food.updatePlus();
			case 2:
				Main.wood.updatePlus();
			case 3:
				Main.metal.updatePlus();
			case 4:
				Main.money.plus = Main.money.plus.add(10);
			case 5:
				//nothing
			case 6:
				//nothing
			case 7:
				//nothing
			case 8:
				//nothing
			case 9:
				Main.upgradeAmountMult = Main.upgradeAmountMult.add(0.01);
			case 10:
				Main.upgradeSpeedMult = Main.upgradeSpeedMult.add(0.01);
			case 11:
				Main.electricity.plus = Main.electricity.plus.add(3);
				Main.wood.autoCost = Main.wood.autoCost.add(1000);
			case 12:
				Main.electricity.plus = Main.electricity.plus.add(1);
			case 13:
				Main.electricity.plus = Main.electricity.plus.add(10);
			case 14:
				Main.electricity.plus = Main.electricity.plus.add(100);
				Main.metal.autoCost = Main.metal.autoCost.add(100000);
			case 100:
				//nothing
			case 101:
				//nothing
			case 102:
				//nothing
			case 103:
				//nothing
			case 104:
				//nothing
			case 105:
				//nothing
			case 106:
				//nothing
			case 107:
				//nothing
			case 108:
				//nothing
			case 109:
				//nothing
			case 110:
				//TODO: breakthrough
			case 111:
				//TODO: upgrade cost
		}
	}
	
	private override function increaseCost(){
		switch(this.type){
			case building:
				this.moneyCost = Math.pow(this.moneyCost, 1.04);
				this.foodCost = Math.pow(this.foodCost, 1.04);
				this.woodCost = Math.pow(this.woodCost, 1.04);
				this.metalCost = Math.pow(this.metalCost, 1.04);
				this.formalCost = Math.pow(this.formalCost, 1.04);
				this.physicalCost = Math.pow(this.physicalCost, 1.04);
				this.lifeCost = Math.pow(this.lifeCost, 1.04);
				this.appliedCost = Math.pow(this.appliedCost, 1.04);
				this.socialCost = Math.pow(this.socialCost, 1.04);
				this.electricityCost = Math.pow(this.electricityCost, 1.04);
			case research:
				this.moneyCost = Math.pow(this.moneyCost, 1.04);
				this.foodCost = Math.pow(this.foodCost, 1.04);
				this.woodCost = Math.pow(this.woodCost, 1.04);
				this.metalCost = Math.pow(this.metalCost, 1.04);
				this.formalCost = Math.pow(this.formalCost, 1.04);
				this.physicalCost = Math.pow(this.physicalCost, 1.04);
				this.lifeCost = Math.pow(this.lifeCost, 1.04);
				this.appliedCost = Math.pow(this.appliedCost, 1.04);
				this.socialCost = Math.pow(this.socialCost, 1.04);
				this.electricityCost = Math.pow(this.electricityCost, 1.04);
			case skill:
			case perk:
				this.perkCost = Math.pow(this.perkCost, 1.2) + 1;
		}
	}
}