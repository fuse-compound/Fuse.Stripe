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
    public class CardParams
    {
        public string Number;
        public int ExpiryMonth;
        public int ExpiryYear;
        public string CVC;
    }
}
