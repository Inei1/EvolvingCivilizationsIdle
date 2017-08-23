package upgrades;
import Thx.Decimal;

class Buyable {
	
	public function new(name: String, id: Int, ?amount: Decimal, ?moneyCost: Decimal, ?foodCost: Decimal, ?woodCost: Decimal, ?metalCost: Decimal,
	?populationCost: Decimal, ?populationMaxCost: Decimal, ?formalCost: Decimal, ?physicalCost: Decimal, ?lifeCost: Decimal, ?appliedCost: Decimal,
	?socialCost: Decimal, ?electricityCost: Decimal, ?perkCost: Decimal, ?skillCost: Decimal, ?maxLevel: Int){
		this.id = id;
		this.name = name;
		this.amount = amount;
		this.moneyCost = moneyCost;
		this.foodCost = foodCost;
		this.woodCost = woodCost;
		this.metalCost = metalCost;
		this.populationCost = populationCost;
		this.populationMaxCost = populationMaxCost;
		this.formalCost = formalCost;
		this.physicalCost = physicalCost;
		this.lifeCost = lifeCost;
		this.appliedCost = appliedCost;
		this.socialCost = socialCost;
		this.electricityCost = electricityCost;
		this.perkCost = perkCost;
		this.skillCost = skillCost;
		this.maxLevel = maxLevel;
	}
	
	private var id: Int=0;
	private var name: String="";
	public var amount: Decimal=0;
	public var moneyCost: Decimal=0;
	public var foodCost: Decimal=0;
	public var woodCost: Decimal=0;
	public var metalCost: Decimal=0;
	public var populationCost: Decimal=0;
	public var populationMaxCost: Decimal=0;
	public var formalCost: Decimal=0;
	public var physicalCost: Decimal=0;
	public var lifeCost: Decimal=0;
	public var appliedCost: Decimal=0;
	public var socialCost: Decimal=0;
	public var electricityCost: Decimal=0;
	public var perkCost: Decimal=0;
	public var skillCost: Decimal=0;
	public var maxLevel: Int=2147483647; //max int value
	
	public inline function getId(): Int{
		return this.id;
	}
	
	public inline function getName(): String{
		return this.name;
	}
	
	public function onClick(): Void{}
	public function format(?type: String): String{
		var number = Decimal.zero;
		switch(type){
			case "money":
				number = this.moneyCost;
			case "food":
				number = this.foodCost;
			case "wood":
				number = this.woodCost;
			case "metal":
				number = this.metalCost;
			case "population":
				number = this.populationCost;
			case "populationMax":
				number = this.populationMaxCost;
			case "formal":
				number = this.formalCost;
			case "physical":
				number = this.physicalCost;
			case "life":
				number = this.lifeCost;
			case "applied":
				number = this.appliedCost;
			case "social":
				number = this.socialCost;
			case "electricity":
				number = this.electricityCost;
			case "perkPoint":
				number = this.perkCost;
			case "skillPoint":
				number = this.skillCost;
			default:
				return "0";
		}
		return Util.formatDecimal(number);
	}
	public function isBuyable(): Bool{
		if (this.moneyCost == null) this.moneyCost = Decimal.zero;
		if (this.foodCost == null) this.foodCost = Decimal.zero;
		if (this.woodCost == null) this.woodCost = Decimal.zero;
		if (this.metalCost == null) this.metalCost = Decimal.zero;
		if (this.populationCost == null) this.populationCost = Decimal.zero;
		if (this.populationMaxCost == null) this.populationMaxCost = Decimal.zero;
		if (this.formalCost == null) this.formalCost = Decimal.zero;
		if (this.physicalCost == null) this.physicalCost = Decimal.zero;
		if (this.lifeCost == null) this.lifeCost = Decimal.zero;
		if (this.appliedCost == null) this.appliedCost = Decimal.zero;
		if (this.socialCost == null) this.socialCost = Decimal.zero;
		if (this.electricityCost == null) this.electricityCost = Decimal.zero;
		if (this.perkCost == null) this.perkCost = Decimal.zero;
		if (this.skillCost == null) this.skillCost = Decimal.zero;
		
		return (Main.money.amount >= this.moneyCost && Main.food.amount >= this.foodCost && Main.wood.amount >= this.woodCost
		&& Main.metal.amount >= this.metalCost && Main.population.amount >= this.populationCost && Main.populationMax.amount >= this.populationMaxCost
		&& Main.formal.amount >= this.formalCost && Main.physical.amount >= this.physicalCost && Main.life.amount >= this.lifeCost
		&& Main.applied.amount >= this.appliedCost && Main.social.amount >= this.socialCost && this.amount != this.maxLevel);
	}
	
	private function takeResources(): Void{
		Main.money.amount -= this.moneyCost;
		Main.food.amount -= this.foodCost;
		Main.wood.amount -= this.woodCost;
		Main.metal.amount -= this.metalCost;
		Main.population.amount -= this.populationCost;
		Main.populationMax.amount -= this.populationMaxCost;
		Main.formal.amount -= this.formalCost;
		Main.physical.amount -= this.physicalCost;
		Main.life.amount -= this.lifeCost;
		Main.applied.amount -= this.appliedCost;
		Main.social.amount -= this.socialCost;
		Main.electricity.amount -= this.electricityCost;
		Main.skillPoint.amount -= this.skillCost;
		Main.perkPoint.amount -= this.perkCost;
	}
	
	private function increaseCost(): Void{}
}