using Uno;
using Uno.UX;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse;
using Fuse.Triggers;
using Fuse.Controls;
using Fuse.Controls.Native;
using Fuse.Controls.Native.Android;

namespace Fuse.Stripe
{
	extern(!mobile)
	public class Core
	{
		static public void Init() { }
	}

	[Require("Cocoapods.Podfile.Target", "pod 'Stripe'")]
	[Require("Source.Include", "Stripe.h")]
	extern(iOS)
	public class Core
	{
		internal static string _publishableKey = extern<string>"uString::Ansi(\"@(Project.Stripe.PublishableKey:Or(''))\")";

		[Foreign(Language.ObjC)]
		static public void Init()
		@{
			[[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@{Core._publishableKey:Get()}];
		@}
	}

	[Require("Gradle.Dependency.Compile", "com.stripe:stripe-android:2.0.2")]
	extern(Android)
	public class Core
	{
		internal static string _publishableKey = extern<string>"uString::Ansi(\"@(Project.Stripe.PublishableKey:Or(''))\")";

		[Foreign(Language.Java)]
		static public void Init()
		@{
		@}
	}
}
