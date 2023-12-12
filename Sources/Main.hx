package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static var logo = ["1 1 1 1 111", "11  111 111", "1 1 1 1 1 1"];
        static var smooth = 2.2;
        static var scale = 51/100;
        static var outline = 0;
        static var topradius = 10*scale;
        static var bottomradius = 8*scale;
        static var topcolor = 0xffaaaaaa;
        static var bottomcolor = 0xffcccccc;
        static var backgroundcolor = Color.Black;
        static var xcoord1 = 30;
        static var ycoord1 = 20;
        static var xcoord2 = 30+300*scale;
        static var ycoord2 = 20;


	static function update(): Void {
	}

	static function render(frames: Array<Framebuffer>): Void {
        var sdfPainter = new SDFPainter(frames[0]);

        sdfPainter.begin();  // takes the same arguments as a normal g2 instance.

        //ISO shape (units are 1/100 of 1U)
        sdfPainter.color = bottomcolor;
        //basic rectangle
        sdfPainter.sdfRect(xcoord1+  0,ycoord1+  0, 150*scale, 100*scale, {tr: bottomradius}, outline, backgroundcolor, smooth);
        //overlapping lower part:
        sdfPainter.sdfRect(xcoord1+ 25*scale,ycoord1+  100*scale-bottomradius, 125*scale, 100*scale+bottomradius, {tr: bottomradius}, outline, backgroundcolor, smooth);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord1+ 25*scale,ycoord1+100*scale, bottomradius,  outline, backgroundcolor, smooth);
        sdfPainter.color = backgroundcolor;
        //the cutter
        sdfPainter.sdfCircle(xcoord1+ 25*scale-bottomradius,ycoord1+100*scale+bottomradius, bottomradius,  outline, backgroundcolor, smooth);

        //the top:
        sdfPainter.color = topcolor;
        //basic rectangle
        sdfPainter.sdfRect(xcoord1+ topradius*2,ycoord1+ topradius*1, 150*scale-topradius*4,  100*scale-topradius*4, {tr: topradius}, outline, backgroundcolor, smooth);
        //overlapping lower part:
        sdfPainter.sdfRect(xcoord1+ 25*scale+topradius*2,ycoord1+ topradius*1, 125*scale-topradius*4, 200*scale-topradius*4, {tr: topradius}, outline, backgroundcolor, smooth);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord1+ 25*scale+topradius*2,ycoord1+ 100*scale-topradius*3, topradius*1,  outline, backgroundcolor, smooth);
        //the cutter
        sdfPainter.color = bottomcolor;
        sdfPainter.sdfCircle(xcoord1+ 25*scale+topradius*2-topradius*1,ycoord1+ 100*scale-topradius*3+topradius*1, topradius*1,  outline, backgroundcolor, smooth);

        //BAE shape (units are 1/100 of 1U)
        sdfPainter.color = bottomcolor;
        //overlapping upper part:
        sdfPainter.sdfRect(xcoord2+75*scale,ycoord2+  0, 150*scale, 100*scale+bottomradius, {tr: bottomradius}, outline, backgroundcolor, smooth);
        //basic rectangle
        sdfPainter.sdfRect(xcoord2+ 0,ycoord2+100*scale, 225*scale, 100*scale, {tr: bottomradius}, outline, backgroundcolor, smooth);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord2+75*scale,ycoord2+100*scale, bottomradius,  outline, backgroundcolor, smooth);
        sdfPainter.color = backgroundcolor;
        //the cutter
        sdfPainter.sdfCircle(xcoord2+75*scale-bottomradius,ycoord2+100*scale-bottomradius, bottomradius,  outline, backgroundcolor, smooth);

        //the top:
        sdfPainter.color = topcolor;
        //overlapping lower part:
        sdfPainter.sdfRect(xcoord2+ 75*scale+topradius*2,ycoord2+ topradius*1, 150*scale-topradius*4, 200*scale-topradius*4, {tr: topradius}, outline, backgroundcolor, smooth);
        //basic rectangle
        sdfPainter.sdfRect(xcoord2+ topradius*2,ycoord2+100*scale+ topradius*1, 225*scale-topradius*4,  100*scale-topradius*4, {tr: topradius}, outline, backgroundcolor, smooth);
        //inner meat to be cut off later
        sdfPainter.sdfCircle(xcoord2+ 75*scale+topradius*2,ycoord2+ 100*scale+topradius*1, topradius*1,  outline, backgroundcolor, smooth);
        //the cutter
        sdfPainter.color = bottomcolor;
        sdfPainter.sdfCircle(xcoord2+ 75*scale+topradius*2-topradius,ycoord2+ 100*scale+topradius*1-topradius, topradius,  outline, backgroundcolor, smooth);

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
