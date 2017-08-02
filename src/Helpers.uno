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
    internal static class Helpers
    {
        [Foreign(Language.ObjC)]
        extern(iOS)
        static ObjC.Object NewISOFormatter()
        @{
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
            return dateFormatter;
        @}

        extern(iOS) static ObjC.Object _dateFormatter = null;
        extern(iOS) static ObjC.Object GetISOFormatter()
        {
            if (_dateFormatter == null)
                _dateFormatter = NewISOFormatter();
            return _dateFormatter;
        }

        [Foreign(Language.ObjC)]
        extern(iOS)
        public static string NSDateToUTCISO(ObjC.Object dt)
        @{
            NSDateFormatter* dateFormatter = (NSDateFormatter*)@{GetISOFormatter():Call()};
            NSDate* dateTime = (NSDate*)dt;
            return [dateFormatter stringFromDate:dateTime];
        @}
    }
}
