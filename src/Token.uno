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
    public extern(!MOBILE) class Token
    {
        public string ID = "the_stripe_token";

        public string Created = "2101-01-01T00:00:00Z";

        public bool LiveMode = false;

        public string Type = "n/a";

        public bool Used = false;

        public Card Card = new Card();
    }

    [Require("Source.Include", "Stripe.h")]
    public extern(iOS) class Token
    {
        ObjC.Object _handle;

        public extern(iOS) Token(ObjC.Object foreignToken)
        {
            _handle = foreignToken;
        }


        [Foreign(Language.ObjC)]
        public string ID
        {
            get
            @{
                STPToken* token = (STPToken*)@{Token:Of(_this)._handle};
                return token.tokenId;
            @}
        }

        public string Created // Result is UTC time in ISO-8601 format
        {
            get
            {
                return Helpers.NSDateToUTCISO(GetCreated());
            }
        }

        [Foreign(Language.ObjC)]
        ObjC.Object GetCreated()
        @{
            STPToken* token = (STPToken*)@{Token:Of(_this)._handle};
            return token.created;
        @}

        [Foreign(Language.ObjC)]
        public bool LiveMode
        {
            get
            @{
                STPToken* token = (STPToken*)@{Token:Of(_this)._handle};
                return token.livemode;
            @}
        }

        [Foreign(Language.ObjC)]
        public string Type
        {
            get
            @{
                STPToken* token = (STPToken*)@{Token:Of(_this)._handle};
                return NULL;
            @}
        }

        [Foreign(Language.ObjC)]
        public bool Used
        {
            get
            @{
                STPToken* token = (STPToken*)@{Token:Of(_this)._handle};
                return false;
            @}
        }

        public Card Card
        {
            get
            {
                return new Card(GetCard());
            }
        }

        [Foreign(Language.ObjC)]
        ObjC.Object GetCard()
        @{
            STPToken* token = (STPToken*)@{Token:Of(_this)._handle};
            return token.card;
        @}
    }

    [ForeignInclude(Language.Java,
                    "java.text.SimpleDateFormat",
                    "java.text.DateFormat",
                    "java.util.TimeZone")]
    public extern(Android) class Token
    {
        Java.Object _handle;

        public extern(Android) Token(Java.Object foreignToken)
        {
            _handle = foreignToken;
        }

        [Foreign(Language.Java)]
        public string ID
        {
            get
            @{
                com.stripe.android.model.Token token = (com.stripe.android.model.Token)@{Token:Of(_this)._handle};
                return token.getId();
            @}
        }

        [Foreign(Language.Java)]
        public string Created // Result is UTC time in ISO-8601 format
        {
            get
            @{
                com.stripe.android.model.Token token = (com.stripe.android.model.Token)@{Token:Of(_this)._handle};
                TimeZone tz = TimeZone.getTimeZone("UTC");
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm'Z'"); // Quoted "Z" to indicate UTC, no timezone offset
                df.setTimeZone(tz);
                return df.format(token.getCreated());
            @}
        }

        [Foreign(Language.Java)]
        public bool LiveMode
        {
            get
            @{
                com.stripe.android.model.Token token = (com.stripe.android.model.Token)@{Token:Of(_this)._handle};
                return token.getLivemode();
            @}
        }

        [Foreign(Language.Java)]
        public string Type
        {
            get
            @{
                com.stripe.android.model.Token token = (com.stripe.android.model.Token)@{Token:Of(_this)._handle};
                return token.getType();
            @}
        }

        [Foreign(Language.Java)]
        public bool Used
        {
            get
            @{
                com.stripe.android.model.Token token = (com.stripe.android.model.Token)@{Token:Of(_this)._handle};
                return token.getUsed();
            @}
        }

        public Card Card
        {
            get
            {
                return new Card(GetCard());
            }
        }

        [Foreign(Language.Java)]
        Java.Object GetCard()
        @{
            com.stripe.android.model.Token token = (com.stripe.android.model.Token)@{Token:Of(_this)._handle};
            return token.getCard();
        @}
    }
}
