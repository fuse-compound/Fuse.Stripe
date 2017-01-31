using Uno;
using Uno.UX;
using Uno.Threading;
using Uno.Text;
using Uno.Platform;
using Uno.Compiler.ExportTargetInterop;
using Uno.Collections;
using Fuse;
using Fuse.Scripting;
using Fuse.Reactive;

namespace Fuse.Stripe
{
	/**
	*/
	[UXGlobalModule]
	public sealed class StripeModule : NativeModule
	{
		static readonly StripeModule _instance;

		public StripeModule()
		{
			debug_log "Stripe booting up :)";

			if(_instance != null) return;
			Resource.SetGlobalKey(_instance = this, "Stripe");

			Core.Init();

			// AddMember(new NativeFunction("testFunc", TestFunc));
			//AddMember(new NativeProperty<bool, bool>("testProperty", TestProperty));
			AddMember(new NativePromise<Token, Scripting.Object>("createToken", TokenFromCardParams, TokenToJS));
		}

		//----------------------------------------------------------------------

		// extern(iOS)
		// static bool TestProperty()
		// {
		// 	return Core.TestProperty;
		// }

		//----------------------------------------------------------------------

		// extern(iOS)
		// static string TestFunc(Context c, object[] args)
		// {
		// 	return Core.TestFunc();
		// }

		//-----------------------------------------------------------------------


		static Future<Token> TokenFromCardParams(object[] args)
		{
			var cardParams = CardParamsFromJS((Scripting.Object)args[0]);
			return Transactions.TokenFromCardParams(cardParams);
		}

		static CardParams CardParamsFromJS(Scripting.Object obj)
		{
			var cardParams = new CardParams();
			cardParams.Number = (string)obj["number"];
			cardParams.ExpiryMonth = Marshal.ToInt(obj["exp_month"]);
			cardParams.ExpiryYear = Marshal.ToInt(obj["exp_year"]);
			cardParams.CVC = (string)obj["cvc"];
			return cardParams;
		}

		static Scripting.Object TokenToJS(Context c, Token token)
		{
			var res = c.NewObject();
			res["id"] = token.ID;
			res["object"] = "token";
			res["client_ip"] = null;
			res["created"] = token.Created;
			res["livemode"] = token.LiveMode;
			res["type"] = token.Type;
			res["used"] = token.Used;
			res["card"] = CardToJS(c, token.Card);
			return res;
		}

		static Scripting.Object CardToJS(Context c, Card card)
		{
			var res = c.NewObject();
			res["number"] = card.Number;
			res["cvc"] = card.CVC;
			res["expmonth"] = card.ExpMonth;
			res["expyear"] = card.ExpYear;
			res["name"] = card.Name;
			res["addressline1"] = card.AddressLine1;
			res["addressline2"] = card.AddressLine2;
			res["addresscity"] = card.AddressCity;
			res["addresszip"] = card.AddressZip;
			res["addressstate"] = card.AddressState;
			res["addresscountry"] = card.AddressCountry;
			res["currency"] = card.Currency;
			res["last4"] = card.Last4;
			res["type"] = card.Type;
			res["brand"] = card.Brand;
			res["fingerprint"] = card.Fingerprint;
			res["funding"] = card.Funding;
			res["country"] = card.Country;
			return res;
		}
	}
}
