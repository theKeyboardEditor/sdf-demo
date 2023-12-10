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
        static var topcolor = 0xffaaaaaa;
        static var bottomcolor = 0xffcccccc;
        static var backgroundcolor = Color.Black;
        static var xcoord1 = 30;
        static var ycoord1 = 20;
        static var xcoord2 = 330;
        static var ycoord2 = 20;


	static function update(): Void {
	}

	static function render(frames: Array<Framebuffer>): Void {
        var sdfPainter = new SDFPainter(frames[0]);

        sdfPainter.begin();  // takes the same arguments as a normal g2 instance.

        //ISO shape (units are 1/100 of 1U)
        sdfPainter.color = bottomcolor;
        //basic rectangle
        sdfPainter.sdfRect(xcoord1+  0,ycoord1+  0, 150, 100, {tr: bottomradius}, outline, Color.White, 1.2);
        //overlapping lower part:
        sdfPainter.sdfRect(xcoord1+ 25,ycoord1+  0, 125, 200, {tr: bottomradius}, outline, Color.White, 1.2);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord1+ 25,ycoord1+100, bottomradius*1.5,  outline, Color.White, 1.2);
        sdfPainter.color = backgroundcolor;
        //the cutter
        sdfPainter.sdfRect(xcoord1+  0,ycoord1+100, 25, 25, {tr: bottomradius}, outline, Color.White, 1.2, Black, Black, Black, Black);

        //the top:
        sdfPainter.color = topcolor;
        //basic rectangle
        sdfPainter.sdfRect(xcoord1+ topradius*2,ycoord1+ topradius*1, 150-topradius*4,  100-topradius*4, {tr: topradius}, outline, Color.White, 1.2);
        //overlapping lower part:
        sdfPainter.sdfRect(xcoord1+ 25+topradius*2,ycoord1+ topradius*1, 125-topradius*4, 200-topradius*4, {tr: topradius}, outline, Color.White, 1.2);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord1+ 25+topradius*2,ycoord1+ 100-topradius*3, topradius*1,  outline, Color.White, 1.2);
        //the cutter
        sdfPainter.color = bottomcolor;
        sdfPainter.sdfRect(xcoord1+ 25-topradius*0,ycoord1+ 100-topradius*3, topradius*2, topradius*2, {tr: topradius}, outline, Color.White, 1.2);

        //BAE shape (units are 1/100 of 1U)
        sdfPainter.color = bottomcolor;
        //overlapping upper part:
        sdfPainter.sdfRect(xcoord2+75,ycoord2+  0, 150, 200, {tr: bottomradius}, outline, Color.White, 1.2);
        //basic rectangle
        sdfPainter.sdfRect(xcoord2+ 0,ycoord2+100, 225, 100, {tr: bottomradius}, outline, Color.White, 1.2);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord2+75,ycoord2+100, bottomradius*1.5,  outline, Color.White, 1.2);
        sdfPainter.color = backgroundcolor;
        //the cutter
        sdfPainter.sdfRect(xcoord2+ 75-25,ycoord2+100-25, 25, 25, {tr: bottomradius}, outline, Color.White, 1.2, Black, Black, Black, Black);

        //the top:
        sdfPainter.color = topcolor;
        //overlapping lower part:
        sdfPainter.sdfRect(xcoord2+ 75+topradius*2,ycoord2+ topradius*1, 150-topradius*4, 200-topradius*4, {tr: topradius}, outline, Color.White, 1.2);
        //basic rectangle
        sdfPainter.sdfRect(xcoord2+ topradius*2,ycoord2+100+ topradius*1, 225-topradius*4,  100-topradius*4, {tr: topradius}, outline, Color.White, 1.2);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord2+ 75+topradius*2,ycoord2+ 100+topradius*1, topradius*1,  outline, Color.White, 1.2);
        //the cutter
        sdfPainter.color = bottomcolor;
        sdfPainter.sdfRect(xcoord2+ 75-topradius*0,ycoord2+ 100-topradius*1, topradius*2, topradius*2, {tr: topradius}, outline, Color.White, 1.2);

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
