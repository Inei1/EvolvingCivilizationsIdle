import js.jquery.JQuery;
import haxe.Timer;
import haxe.macro.Expr;
import upgrades.ResourceUpgrade;

import Thx.Decimal;
import Thx.Floats;

import UpdateUI;

class Resource {
	private var name: String;
	private var id: Int;
	@optional private var upgrades: Array<ResourceUpgrade> = [];
	public var amount: Decimal;
	public var plus: Decimal;
	public var autoCost: Decimal;
	public var buildingBonus: Int;
	@optional private var barInc: Float;
	@optional private var progress: Float;
	@optional private var timer: Timer;

	public function new(name, id, ?amount: Decimal, ?plus: Decimal, ?autoCost: Decimal){
		this.name = name;
		this.id = id;
		this.amount = amount;
		this.plus = plus;
		this.autoCost = autoCost;
	}
	
	public function setupBar(): Resource{
		this.barInc = 1;
		this.progress = 0;
		this.timer = new Timer(100);
		switch(this.name){
			case "food":
				this.upgrades.push(Main.newFarmer);
				this.upgrades.push(Main.farmerUpgrade1);
				this.upgrades.push(Main.farmerUpgrade2);
			case "wood":
				this.upgrades.push(Main.newWoodcutter);
				this.upgrades.push(Main.woodcutterUpgrade1);
				this.upgrades.push(Main.woodcutterUpgrade2);
			case "metal":
				this.upgrades.push(Main.newMiner);
				this.upgrades.push(Main.minerUpgrade1);
				this.upgrades.push(Main.minerUpgrade2);
		}
		timer.run = updateProgressBar;
		return this;
	}
	
	public inline function getName(): String{
		return this.name;
	}
	
	public inline function getUpgrades(): Array<ResourceUpgrade>{
		return this.upgrades;
	}
	
	public function format(): String{
		return Util.formatDecimal(this.amount);
	}
	
	public function updatePlus(): Decimal{
		if (this.plus == null || this.upgrades[1] == null || this.upgrades[0] == null){
			return Decimal.zero;
		}
		this.plus = (this.upgrades[0].amount * 100 * Math.pow(Main.upgradeAmountMult, this.upgrades[1].amount));
		return this.plus;
	}
	
	public function updateBarInc(): Decimal{
		if (this.barInc == null || this.upgrades[2] == null){
			return Decimal.zero;
		}
		this.barInc = Math.pow(Main.upgradeSpeedMult, this.upgrades[2].amount);
		return this.barInc;
	}
	
	public function getResourceAdd(): Decimal{
		return (this.plus - this.autoCost) * "10";
	}
	
	private function addProgress(){
		this.progress += this.barInc;
		if (this.progress >= 100){
			this.addResources();
			this.progress = 0;
		}
	}
	
	private function addResources(){
		this.amount += this.getResourceAdd();
		UpdateUI.updateResource(this);
		Util.saveGame();
	}
	
	private function updateProgressBar(){
		new JQuery((".progress-bar-" + this.name)).css("width", this.progress + "%");
		new JQuery((".progress-bar-" + this.name)).text(Floats.roundTo(this.progress, 2) + "%");
		this.addProgress();
	}
	
}