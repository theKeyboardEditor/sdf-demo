package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static var logo = ["1 1 1 1 111", "11  111 111", "1 1 1 1 1 1"];

	static function update(): Void {
	}

	static function render(frames: Array<Framebuffer>): Void {
        var sdfPainter = new SDFPainter(frames[0]);

        sdfPainter.begin();  // takes the same arguments as a normal g2 instance.
        sdfPainter.color = Color.Red;
        sdfPainter.sdfRect(10, 10, 400, 60, {tr: 20, br: 20, tl: 5, bl: 5}, 5, Color.White, 2.2);
        sdfPainter.color = Color.Cyan;
        sdfPainter.sdfCircle(640, 360, 60, 7, Color.Orange, 2.2);

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
