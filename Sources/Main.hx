package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static var logo = ["1 1 1 1 111", "11  111 111", "1 1 1 1 1 1"];
        static var outline = 0;
        static var topradius = 8;
        static var bottomradius = 4;

	static function update(): Void {
	}

	static function render(frames: Array<Framebuffer>): Void {
        var sdfPainter = new SDFPainter(frames[0]);

        sdfPainter.begin();  // takes the same arguments as a normal g2 instance.

        //ISO shape (units are 1/100 of 1U)
        //basic rectangle
        sdfPainter.color = 0xffcccccc;
        sdfPainter.sdfRect(30+  0,20+  0, 150, 100, {tr: bottomradius}, outline, Color.White, 1.2);
        //overlapping lower part:
        sdfPainter.sdfRect(30+ 25,20+  0, 125, 200, {tr: bottomradius}, outline, Color.White, 1.2);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(30+ 25,20+100, bottomradius*1.5,  outline, Color.White, 1.2);
        sdfPainter.color = Color.Black;
        //the cutter
        sdfPainter.sdfRect(30+  0,20+100, 25, 25, {tr: bottomradius}, outline, Color.White, 1.2, Black, Black, Black, Black);

        //the top:
        sdfPainter.color = 0xffaaaaaa;
        //basic rectangle
        sdfPainter.sdfRect(30+ topradius*2,20+ topradius*1, 150-topradius*4,  100-topradius*4, {tr: topradius}, outline, Color.White, 1.2);
        //overlapping lower part:
        sdfPainter.sdfRect(30+ 25+topradius*2,20+ topradius*1, 125-topradius*4, 200-topradius*4, {tr: topradius}, outline, Color.White, 1.2);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(30+ 25+topradius*2,20+ 100-topradius*3, topradius*1,  outline, Color.White, 1.2);
        //the cutter
        sdfPainter.color = 0xffcccccc;
        sdfPainter.sdfRect(30+ 25-topradius*0,20+ 100-topradius*3, topradius*2, topradius*2, {tr: topradius}, outline, Color.White, 1.2);

        sdfPainter.end();
    }

	public static function main() {
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { render(frames); });
			});
		});
	}
}
