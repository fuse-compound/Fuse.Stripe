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
    extern(!MOBILE) class ValidateCardParams : Promise<CardValidation>
    {
        public ValidateCardParams(CardParams uCardParams)
        {
            Resolve(new CardValidation("valid", "invalid", "unknown"));
        }
    }

    [ForeignInclude(Language.Java,
                    "com.stripe.android.model.Token",
                    "com.stripe.android.Stripe",
                    "com.stripe.android.TokenCallback",
                    "com.stripe.android.model.Card")]
    extern(Android) class ValidateCardParams : Promise<CardValidation>
    {
        [Foreign(Language.Java)]
        public ValidateCardParams(CardParams uCardParams)
        @{
            String cvc = @{CardParams:Of(uCardParams).CVC:Get()};
            Card card = new Card(@{CardParams:Of(uCardParams).Number:Get()},
                                 @{CardParams:Of(uCardParams).ExpiryMonth:Get()},
                                 @{CardParams:Of(uCardParams).ExpiryYear:Get()},
                                 cvc);

            String numberValid = card.validateNumber() ? "valid" : "invalid";
            String expiryValid = card.validateExpiryDate() ? "valid" : "invalid";
            String cvcValid = cvc == null ? "valid" : card.validateCVC() ? "valid" : "invalid";

            @{ValidateCardParams:Of(_this).Resolve(string,string,string):Call(numberValid, expiryValid, cvcValid)};
        @}

        void Resolve(string number, string expiry, string cvc)
        {
            var valid = new CardValidation(number, expiry, cvc);
            Resolve(valid);
        }
    }

    [extern(iOS) Require("Source.Include", "Stripe.h")]
    extern(iOS) class ValidateCardParams : Promise<CardValidation>
    {
        public ValidateCardParams(CardParams cardParams)
        {
            var num = cardParams != null ? cardParams.Number : "";
            var monthStr = cardParams != null ? cardParams.ExpiryMonth.ToString() : "";
            var yearStr = cardParams != null ? cardParams.ExpiryYear.ToString() : "";
            var cvc = cardParams != null ? cardParams.CVC : "";
            Validate(num, monthStr, yearStr, cvc);
        }

        [Foreign(Language.ObjC)]
        void Validate(string numStr, string monthStr, string yearStr, string cvcStr)
        @{
            long number = (long)[STPCardValidator validationStateForNumber:numStr validatingCardBrand: NO];
            STPCardValidationState month = [STPCardValidator validationStateForExpirationMonth:monthStr];
            STPCardValidationState year = [STPCardValidator validationStateForExpirationYear:yearStr inMonth:monthStr];
            long expiry = (long)(year == STPCardValidationStateValid && month == STPCardValidationStateValid) ? STPCardValidationStateValid : STPCardValidationStateInvalid;
            STPCardBrand brand = [STPCardValidator brandForNumber:numStr];
            long cvc = (long)[STPCardValidator validationStateForCVC:cvcStr cardBrand: brand];

            @{ValidateCardParams:Of(_this).Resolve(long,long,long):Call(number, expiry, cvc)};
        @}

        [Foreign(Language.ObjC)]
        string StateToString(long state)
        @{
            switch ((STPCardValidationState)state)
            {
                case STPCardValidationStateValid:
                    return @"valid";
                case STPCardValidationStateInvalid:
                    return @"invalid";
                case STPCardValidationStateIncomplete:
                    return @"incomplete";
                default:
                    return @"unknown";
            }
        @}

        void Resolve(long number, long expiry, long cvc)
        {
            var valid = new CardValidation(StateToString(number), StateToString(expiry), StateToString(cvc));
            Resolve(valid);
        }
    }
}
