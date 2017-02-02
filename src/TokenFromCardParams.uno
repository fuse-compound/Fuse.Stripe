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
	[extern(iOS) Require("Source.Include", "Stripe.h")]
	extern(iOS) class TokenFromCardParams : Promise<Token>
	{
		[Foreign(Language.ObjC)]
		public TokenFromCardParams(CardParams uCardParams)
		@{
			STPCardParams *cardParams = [[STPCardParams alloc] init];
			cardParams.number = @{CardParams:Of(uCardParams).Number:Get()};
			cardParams.expMonth = @{CardParams:Of(uCardParams).ExpiryMonth:Get()};
			cardParams.expYear = @{CardParams:Of(uCardParams).ExpiryYear:Get()};
			cardParams.cvc = @{CardParams:Of(uCardParams).CVC:Get()};

			//-----
			[[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken *token, NSError *error) {
				if (error) {
					@{TokenFromCardParams:Of(_this).Reject(string):Call(error.description)};
				} else {
					@{TokenFromCardParams:Of(_this).Resolve(ObjC.Object):Call(token)};
				}
			}];
		@}

		void Resolve(ObjC.Object token) //STPToken
		{
			var uToken = new Token(token);
			Resolve(uToken);
		}

		void Reject(string reason)
		{
			Reject(new Exception(reason));
		}
	}



	[ForeignInclude(Language.Java,
					"com.stripe.android.model.Token",
					"com.stripe.android.Stripe",
					"com.stripe.android.TokenCallback",
					"com.stripe.android.model.Card")]
	extern(Android) class TokenFromCardParams : Promise<Token>
	{
		[Foreign(Language.Java)]
		public TokenFromCardParams(CardParams uCardParams)
		@{
			Card card = new Card(@{CardParams:Of(uCardParams).Number:Get()},
								 @{CardParams:Of(uCardParams).ExpiryMonth:Get()},
								 @{CardParams:Of(uCardParams).ExpiryYear:Get()},
								 @{CardParams:Of(uCardParams).CVC:Get()});
			Stripe stripe;
			try
			{
				stripe = new Stripe(@{Core._publishableKey:Get()});
			}
			catch (Exception e)
			{
				@{TokenFromCardParams:Of(_this).Reject(string):Call(e.getMessage())};
				return;
			}
			stripe.createToken(
				card,
				new TokenCallback()
				{
					public void onSuccess(Token token)
					{
						@{TokenFromCardParams:Of(_this).Resolve(Java.Object):Call(token)};
					}
					public void onError(Exception error)
					{
						@{TokenFromCardParams:Of(_this).Reject(string):Call(error.getMessage())};
					}
				}
			);
		@}

		void Resolve(Java.Object token) //STPToken
		{
			var uToken = new Token(token);
			Resolve(uToken);
		}

		void Reject(string reason)
		{
			Reject(new Exception(reason));
		}
	}
}
