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
    public class CardValidation
    {
        public readonly string NumberValid;
        public readonly string ExpiryValid;
        public readonly string CVCValid;

        public CardValidation( string numberValid,  string expiryValid,  string cvcValid)
        {
            NumberValid = numberValid;
            ExpiryValid = expiryValid;
            CVCValid = cvcValid;
        }
    }
}
