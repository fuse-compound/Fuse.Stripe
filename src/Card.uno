using Uno;
using Uno.UX;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse;
using Fuse.Triggers;
using Fuse.Controls;
using Fuse.Controls.Native;
using Fuse.Controls.Native.Android;

namespace Fuse.Stripe
{
	public extern(!mobile) class Card
	{
		public extern(iOS) Card(object foreignCard)
		{
		}
	}

	[Require("Source.Include", "Stripe.h")]
	[Require("Source.Include", "STPCardBrand.h")]
	public extern(iOS) class Card
	{
		ObjC.Object _handle;

		public extern(iOS) Card(ObjC.Object foreignCard)
		{
			_handle = foreignCard;
		}

		public string Number
		{
			get
			{
				//STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				//return card.number;
				return "Deprecated On iOS";
			}
		}


		public string CVC
		{
			get
			{
				// STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				// return card.cVC;
				return "Deprecated On iOS";
			}
		}


		[Foreign(Language.ObjC)]
		public int ExpMonth
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return (int)card.expMonth;
			@}
		}


		[Foreign(Language.ObjC)]
		public int ExpYear
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return (int)card.expYear;
			@}
		}


		[Foreign(Language.ObjC)]
		public string Name
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.name;
			@}
		}


		[Foreign(Language.ObjC)]
		public string AddressLine1
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.addressLine1;
			@}
		}


		[Foreign(Language.ObjC)]
		public string AddressLine2
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.addressLine2;
			@}
		}


		[Foreign(Language.ObjC)]
		public string AddressCity
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.addressCity;
			@}
		}


		[Foreign(Language.ObjC)]
		public string AddressState
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.addressState;
			@}
		}


		[Foreign(Language.ObjC)]
		public string AddressZip
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.addressZip;
			@}
		}


		[Foreign(Language.ObjC)]
		public string AddressCountry
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.addressCountry;
			@}
		}

		[Foreign(Language.ObjC)]
		public string Currency
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.currency;
			@}
		}


		[Foreign(Language.ObjC)]
		public string Last4
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.last4;
			@}
		}

		public string Type
		{
			get
			{
				// STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				// return card.type;
				return "Deprecated On iOS";
			}
		}


		[Foreign(Language.ObjC)]
		public string Brand
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};

				if (card.brand == STPCardBrandVisa)
					return @"Visa";
				if (card.brand == STPCardBrandAmex)
					return @"Amex";
				if (card.brand == STPCardBrandMasterCard)
					return @"MasterCard";
				if (card.brand == STPCardBrandDiscover)
					return @"Discover";
				if (card.brand == STPCardBrandJCB)
					return @"JCB";
				if (card.brand == STPCardBrandDinersClub)
					return @"DinersClub";
				else
					return @"Unknown";
			@}
		}

		public string Fingerprint
		{
			get
			{
				// STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				// return card.fingerprint;
				return "Deprecated On iOS";
			}
		}


		[Foreign(Language.ObjC)]
		public string Funding
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				if (card.funding == STPCardFundingTypeDebit)
					return @"Debit";
				if (card.funding == STPCardFundingTypeCredit)
					return @"Credit";
				if (card.funding == STPCardFundingTypePrepaid)
					return @"Prepaid";
				else
					return @"Other";
			@}
		}

		[Foreign(Language.ObjC)]
		public string Country
		{
			get
			@{
				STPCard* card = (STPCard*)@{Card:Of(_this)._handle};
				return card.country;
			@}
		}
	}


	public extern(Android) class Card
	{
		Java.Object _handle;

		public extern(Android) Card(Java.Object foreignCard)
		{
			_handle = foreignCard;
		}

		[Foreign(Language.Java)]
		public string Number
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getNumber();
			@}
		}

		[Foreign(Language.Java)]
		public string CVC
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getCVC();
			@}
		}

		[Foreign(Language.Java)]
		public int ExpMonth
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return (int)card.getExpMonth();
			@}
		}

		[Foreign(Language.Java)]
		public int ExpYear
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return (int)card.getExpYear();
			@}
		}

		[Foreign(Language.Java)]
		public string Name
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getName();
			@}
		}

		[Foreign(Language.Java)]
		public string AddressLine1
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getAddressLine1();
			@}
		}

		[Foreign(Language.Java)]
		public string AddressLine2
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getAddressLine2();
			@}
		}

		[Foreign(Language.Java)]
		public string AddressCity
		{
		get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getAddressCity();
			@}
		}

		[Foreign(Language.Java)]
		public string AddressZip
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getAddressZip();
			@}
		}

		[Foreign(Language.Java)]
		public string AddressState
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getAddressState();
			@}
		}

		[Foreign(Language.Java)]
		public string AddressCountry
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getAddressCountry();
			@}
		}

		[Foreign(Language.Java)]
		public string Currency
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getCurrency();
			@}
		}

		[Foreign(Language.Java)]
		public string Last4
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getLast4();
			@}
		}

		[Foreign(Language.Java)]
		public string Type
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getType();
			@}
		}

		[Foreign(Language.Java)]
		public string Brand
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getBrand();
			@}
		}

		[Foreign(Language.Java)]
		public string Fingerprint
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getFingerprint();
			@}
		}

		[Foreign(Language.Java)]
		public string Funding
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getFunding();
			@}
		}

		[Foreign(Language.Java)]
		public string Country
		{
			get
			@{
				com.stripe.android.model.Card card = (com.stripe.android.model.Card)@{Card:Of(_this)._handle};
				return card.getCountry();
			@}
		}
	}
}
