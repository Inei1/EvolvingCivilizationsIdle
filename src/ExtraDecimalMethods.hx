package;

import Thx.Decimal;

//these methods are ported to haxe from a java library: https://arxiv.org/abs/0908.3030
//they are NOT appropriate for every possible condition, so use them with caution, and they are not 100% precise
//these are a little bit too slow, so I think the loss in precision with floats is better than the game freezing up.

//-----------NOT USED------------
class ExtraDecimalMethods {

	//returns base^exponent
	public static function decimalPowFloat(base: Decimal, exponent: Decimal): Decimal{
		if(base.compareTo(Decimal.zero) < 0){
            throw "Cannot exponentiate negative number: "+ base.toString();
        } else if(base.compareTo(Decimal.zero) == 0){
            return Decimal.zero;
        } else {
            var logBase: Decimal = decimalLog(base);
            var exponentTimesLogBase: Decimal = exponent.multiply(logBase);
            var result: Decimal = decimalExp(exponentTimesLogBase);
            return result.round();
        }
	}
	
	public static function decimalRoot(n: Int, base: Decimal){
		if (base.compareTo(Decimal.zero) < 0 )
            throw "cannot evaluate negative argument "+base.toString()+ " of root";
        if (n <= 0)
            throw "cannot evaluate negative power "+ n + " of root";
		if (n == 1)
			return base;
        var s: Decimal = Decimal.fromFloat(Math.pow(base.toFloat(), 1.0 / n)).scaleTo(45);
        var nth: Decimal = Decimal.fromInt(n);
        var xhighpr: Decimal = base.scaleTo(2);
		var eps: Float = 0.0000001;
        while (true){
			trace("root loop");
            var c: Decimal = xhighpr.divide(s.pow(n - 1)).ceilTo(8);
			c = c.scaleTo(8);
            c = s.subtract(c);
            c = c.divide(nth);
            s = s.subtract(c);
            if ( Math.abs( c.toFloat()/s.toFloat()) < eps){
                break;
			}
        }
        return s.roundTo(err2prec(eps));
	}
	
	public static function err2prec(xerr: Float){
		return 1 + Std.int(log10(Math.abs(0.5 / xerr)));
	}
	
	//returns ln(base) by using a taylor series to find ln(x)
	public static function decimalLog(base: Decimal): Decimal{
        if (base <= Decimal.zero){
            throw "Cannot take log of negative number: " + base.toString();
        } else if (base == Decimal.one){
            return Decimal.zero;
        } else if (Math.abs(base.toFloat() - 1.0) <= 0.3 ){
            var z: Decimal = base.subtract(Decimal.one);
            var zpown: Decimal = z;
            var eps: Float = 0.00001;
            var result: Decimal = z;
			var k: Int = 2;
            while (true){
				trace("log loop" + k);
                zpown = zpown.multiply(z).roundTo(z.scale);
                var c: Decimal = zpown.divide(k).roundTo(zpown.scale);
                if ( k % 2 == 0)
                    result = result.subtract(c);
                else
                    result = result.add(c);
                if (Math.abs(c.toFloat()) < eps){
                    break;
				}
				k++;
            }
            return result;
        } else {
            var xDbl: Float = base.toFloat();
			var xUlpDbl: Float = ulp(base).toFloat();
            var r: Int = Std.int(Math.log(xDbl) / 0.2);
			r = Std.int(Math.max(2, r));
            var xhighpr: Decimal = base.scaleTo(4);
            var result: Decimal = decimalRoot(r, xhighpr);
            result = decimalLog(result).multiply(Decimal.fromInt(r));
            return result;
        }
	}
	
	public static function log10(number: Float){
		return Math.log(number) / Math.log(10);
	}
	
	static var maxTerms: Int = 8;
	//returns e^base
	public static function decimalExp(base: Decimal): Decimal{
        if (base < 0){
            var invx: Decimal = decimalExp(base.negate());
            return Decimal.one.divide(invx) ;
        } else if (base == 0){
            return Decimal.one;
        } else {
            var xDbl: Float = base.toFloat();
			var xUlpDbl = ulp(base).toFloat();
            if (Math.pow(xDbl, maxTerms) < maxTerms * (maxTerms-1.0) * (maxTerms-2.0) * xUlpDbl) {
                var result: Decimal = Decimal.one;
                var xpowi: Decimal = Decimal.one;
				var ifac: Decimal = Decimal.one;
				var i: Int = 1;
                for(i in 1...maxTerms){
                    ifac = ifac.multiply(Decimal.fromInt(i));
                    xpowi = xpowi.multiply(base);
                    var c: Decimal = xpowi.divide(Decimal.fromString(ifac.toString()));
                    result = result.add(c);
                    if (Math.abs(xpowi.toFloat()) < i && Math.abs(c.toFloat()) < 0.5 * xUlpDbl)
                         break;
                }
                return result.roundTo(err2prec(xUlpDbl/2));
			} else {
                var exSc: Int = Std.int(1.0 - log10(maxTerms * (maxTerms - 1.0) * (maxTerms - 2.0) * xUlpDbl / Math.pow(xDbl, maxTerms) ) / ( maxTerms - 1.0)) ; 
                var xby10: Decimal = base.multiply(Decimal.fromFloat(Math.pow(10, -exSc)));
                var expxby10: Decimal = decimalExp(xby10);
				trace(expxby10);
                while (exSc > 0){
                    var exsub: Int = cast(Math.min(8,exSc), Int);
                    exSc -= exsub;
                    var pex: Int = 1 ;
                    while (exsub-- > 0)
                        pex *= 10;
					trace(expxby10);
                    expxby10 = decimalPowInt(expxby10, pex);
					trace(expxby10);
                }
                return expxby10.round();
            }
        }
	}
	
	public static function ulp(base: Decimal): Decimal{
        base = base.abs();
        return Math.pow(10, -base.scale);
	}
	
	//the native pow() function sets insanely high precision with large exponents and is far too slow, so this is needed
	public static function decimalPowInt(base: Decimal, exponent: Int): Decimal{
		var scale: Int = base.scale;
		var result: Decimal = 1;
		while (exponent != 0){
			trace("exp:" + exponent);
			if (exponent & 1 != 0){
				result *= base;
			}
			exponent >>= 1;
			base *= base;
			base = base.scaleTo(scale);
		}
		return result;
	}
}