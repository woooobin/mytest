<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
* {
	margin: 0;
	padding: 0;
	font-size: 16px;
}

html, body {
	height: 100%;
	min-width: 960px;
}

input, textarea, select {
	margin-bottom: 8px;
}

.container {
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.section {
	height: 100%;
	width: 100%;
	padding: 8px;
}

.section-form form {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	height: 100%;
}

.section-form form .form-header {
	width: 100%;
	max-width: 600px;
	margin-bottom: 8px;
}

.section-form form .form-body {
	width: 100%;
	max-width: 600px;
	margin-bottom: 8px;
}

.section-form form .form-footer {
	width: 100%;
	max-width: 600px;
}

.section-form form .form-body input {
	width: 100%;
}

.section-form form .form-body textarea {
	width: 100%;
	height: 300px;
	resize: none;
	margin: 8;
}

.section-form form .form-footer button {
	width: 100%;
	padding: 15px;
	font-size: 16px;
}

.section-canvas {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	height: 100%;
	width: 600px;
	background: #000000;
}
</style>
</head>
<body>
	<div class="container">
		<div class="section section-form">
			<form id="form">
				<div class="form-header">
					<h4>추첨 항목 입력</h4>
				</div>
				<div class="form-body">
					<input type="text" name="title" placeholder="추첨 제목을 입력하세요." />
					<textarea name="values" placeholder="추첨 할 항목을 엔터로 구분하여 입력하세요."></textarea>
					<select name="background">
						<optgroup label="단일색상">
							<option value="#FFFFFF">#FFFFFF</option>
							<option value="#000000">#000000</option>
						</optgroup>
						<optgroup label="이미지">
							<option value="assets/001.jpg">001</option>
							<option value="assets/002.jpg">002</option>
							<option value="assets/003.jpg">003</option>
							<option value="assets/004.jpg">004</option>
							<option value="assets/005.jpg">005</option>
						</optgroup>
					</select>
				</div>
				<div class="form-footer">
					<label> <input type="checkbox" name="record" /> <small>WebM
							레코딩 요청</small>
					</label>
					<button name="start" type="submit">추첨 시작</button>
				</div>
			</form>
		</div>
		<div class="section section-canvas">
			<div>
				<canvas id="canvas" width="600" height="600"></canvas>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="assets/whammy.js"></script>
	<script type="text/javascript">window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;</script>
	<script type="text/javascript">
    	class UtilNumber {
				static padZero(str, len) {
			    len = len || 2;
			    var zeros = new Array(len).join('0');
			    return (zeros + str).slice(-len);
				}
    	}
    	class Radians {
    		static toDegrees(radians){ return radians * 180 / Math.PI; }
    	}
    	class Degrees {
    		static toRadians(degrees){ return degrees * Math.PI / 180; }
    	}
    	class Color {
    		static invert(hex){
			    if (hex.indexOf('#') === 0) {
			        hex = hex.slice(1);
			    }
			    if (hex.length === 3) {
			        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
			    }
			    if (hex.length !== 6) {
			        throw new Error('Invalid HEX color.');
			    }
			    var r = (255 - parseInt(hex.slice(0, 2), 16)).toString(16),
			        g = (255 - parseInt(hex.slice(2, 4), 16)).toString(16),
			        b = (255 - parseInt(hex.slice(4, 6), 16)).toString(16);
			    return '#' + UtilNumber.padZero(r) + UtilNumber.padZero(g) + UtilNumber.padZero(b);
    		}
    	}
    	class RouletteCanvas {
				static install(canvas, options) { return new RouletteCanvas(canvas, options); }

				constructor(canvas, options = {}) {
					if(!canvas || !canvas.getContext) throw new Error('올바르지 않은 캔버스입니다.');
					if(!!canvas.roulette) throw new Error('이미 룰렛 이벤트가 등록된 캔버스입니다.');

					const defaults = {
						fps: 30, record: false, values: [],
						fillColors: ["#B8D430", "#3AB745", "#029990", "#3501CB", "#2E2C75", "#673A7E", "#CC0071", "#F80120", "#F35B20", "#FB9A00", "#FFCC00", "#FEF200"],
						title: '', background: '#FFFFFF',
						onCreate() {},
						onStart() {},
						onUpdate() {},
						onRender() {},
						onFinish() {},
						onRecord() {},
						onRecordFinish() {},
					}

					this.finish = true;
					this.timestamp = Date.now();

					this.canvas = canvas;
					this.canvas.roulette = this;

					this.options = Object.assign(defaults, options);
					this.onCreate = this.options.onCreate.bind(this);
					this.onStart = this.options.onStart.bind(this);
					this.onUpdate = this.options.onUpdate.bind(this);
					this.onRender = this.options.onRender.bind(this);
					this.onFinish = this.options.onFinish.bind(this);
					this.onRecord = this.options.onRecord.bind(this);
					this.onFinishWithRecord = undefined;
					this.onRecordFinish = this.options.onRecordFinish;

					this.recorder = new Whammy.Video(this.options.fps);
					if (this.options.values.length > 0) { this.update(this.options); }

					this.onCreate();
				}

				update(options = {}) {
					let values = options.values || [];
					if (!this.finish) throw new Error("이미 룰렛을 돌리는 중입니다.");

					this.options.title = options.title || this.options.title;
					this.options.background = options.background || this.options.background;
					console.log(this.options.background);
					if (this.options.background && !/^#[0-9A-F]+$/i.test(this.options.background)) {
						let image = new Image();
						image.src = this.options.background;
						image.onload = () => this.options.backgroundImage = image;
					} else {
						delete this.options.backgroundImage;
					}
					
					if (typeof values === 'string') values = values.split(/[\s]*[\r\n]+[\s]*/g).filter((label)=>!!label);
					if (!values || values.length <= 1) throw new Error("룰렛 값은 반드시, 2개 이상이어야 합니다.");
					this.options.values = values.sort(() => 0.5 - Math.random()).map((value)=>{
						if (typeof value === 'string') value = { label: value };
						return Object.assign({ label: '', weight: 1, fillColor: undefined }, value)
					});
				}

				render(options = {}, withRecord = false) {
					this.onFinishWithRecord = withRecord && (() => {
						this.onFinishWithRecord = undefined;
						this.onRecord();
						this.recorder.compile(false, this.frameRecordFinish.bind(this));
					});

					this.update(options);
					this.finish = false;
					let frameCountMin = this.options.fps * 5;
					let frameCountMax = this.options.fps * 20;
					let frameCount = Math.floor(Math.random() * (frameCountMax - frameCountMin + 1)) + frameCountMin;
					this.onStart(frameCount);
					this.frameUpdate(frameCount);
				}

				record(options = {}) {
					if(!this.onFinishWithRecord) return this.render(options, true);
					this.onRecord();
					this.recorder.compile(false, this.frameRecordFinish.bind(this));
				}

				frame(rotate = 0) {
					const values = this.options.values;
					const ctx = this.canvas.getContext('2d');
					const canvasW = Math.max(this.canvas.width, this.canvas.offsetWidth, this.canvas.clientWidth);
					const canvasH = Math.max(this.canvas.height, this.canvas.offsetHeight, this.canvas.clientHeight);
					const centerX = canvasW / 2;
					const centerY = canvasH / 2;
					const arrowsX = canvasW / 10;
					const arrowsY = centerY;
	    		// Canvas Background
    			ctx.save();
    			{
    				if (this.options.backgroundImage) {
    					ctx.drawImage(this.options.backgroundImage, 0, 0, canvasW, canvasH)
    				} else {
							ctx.fillStyle = ctx.strokeStyle = this.options.background;
	    				ctx.fillRect(0, 0, canvasW, canvasH);
    				}
	    		}
    			ctx.restore();
	    		// Draw Arrow
    			ctx.save();
    			{
    				ctx.fillStyle = ctx.strokeStyle = '#FF0000'
	    			ctx.beginPath();
				    ctx.moveTo(canvasW - arrowsX, arrowsY);
				    ctx.lineTo(canvasW, arrowsY - 5);
				    ctx.lineTo(canvasW, arrowsY + 5);
				    ctx.fill();
				  }
    			ctx.restore();
	    		// Draw Panels
	    		ctx.save();
	    		{
    				const weightMax = values.reduce((weights, value) => weights + value.weight, 0);
    				const weightVal = (360 / weightMax);
    				let weightCur = 0;

    				let renderW;
						let renderX;
						let renderY;
						switch(true) {
							// size - huge
							case (values.length > 100):
								renderW = canvasW + canvasW - arrowsX;
  							renderX = -canvasW;
  							renderY = centerY;
							break;
							// size - big
							case (values.length > 30):
								renderW = centerX + canvasW - arrowsX;
  							renderX = -centerX;
  							renderY = centerY;
							break;
							// size - normal
							case (values.length > 5):
								renderW = canvasW - arrowsX;
  							renderX = 0;
  							renderY = centerY;
							break;
							// size - small
							default:
  							renderW = centerX - arrowsX;
  							renderX = centerX;
  							renderY = centerY;
							break;
						}

    				values.forEach((value, offset) => {
								const fillColor = value.fillColor || this.options.fillColors[offset % this.options.fillColors.length];
	    					const degreesMin = (weightVal * weightCur) + rotate;
    						const degreesMax = (weightVal * value.weight)
    						value.degreesMin = (degreesMin) % 360;
    						value.degreesMax = (degreesMin + degreesMax) % 360;

								ctx.save();
								{
									ctx.globalAlpha = 0.8;
									ctx.translate(renderX, renderY);
		    					ctx.rotate(Degrees.toRadians(degreesMin % 360));
									ctx.strokeStyle = "#000000";
									ctx.fillStyle = fillColor;
									ctx.beginPath();
						      ctx.arc(0, 0, renderW, Degrees.toRadians(0), Degrees.toRadians(degreesMax));
						      ctx.arc(0, 0, 0, Degrees.toRadians(degreesMax), Degrees.toRadians(0), true);
						      ctx.fill();
						      ctx.stroke();
						      ctx.globalAlpha = 0;
						    }
					      ctx.restore();

					      ctx.save();
					      {
		    					ctx.translate(renderX, renderY);
		    					ctx.rotate(Degrees.toRadians(degreesMin % 360));
		    					ctx.fillStyle = "#FFFFFF";
		    					ctx.textAlign = "end";
		    					ctx.font = "12px Arial";
									ctx.fillText(value.label, renderW - 3, 12 + 3);
								}
								ctx.restore();

					      weightCur = (weightCur + value.weight) % weightMax;
    				})
				  }
			    ctx.restore();

			    ctx.save();
		      {
		      	let time = new Date(this.timestamp).toLocaleString('ko-KR', { timezone: 'UTC' });
  					ctx.fillStyle = "#000000";
  					ctx.textAlign = "start";
  					ctx.font = "12px Arial";
						ctx.fillText(`추첨 시각 : ${time}`, 15 + 1, canvasH - 12 - 15 + 1);

						ctx.fillStyle = "#FFFFFF";
  					ctx.textAlign = "start";
  					ctx.font = "12px Arial";
						ctx.fillText(`추첨 시각 : ${time}`, 15 + 0, canvasH - 12 - 15 + 0);
					}
					ctx.restore();

					ctx.save();
		      {
		      	let time = new Date(this.timestamp).toLocaleString('ko-KR', { timezone: 'UTC' });
  					ctx.fillStyle = "#000000";
  					ctx.textAlign = "center";
  					ctx.font = "16px Arial";
						ctx.fillText(this.options.title, centerX + 1, 16 + 15 + 1);

						ctx.fillStyle = "#FFFFFF";
  					ctx.textAlign = "center";
  					ctx.font = "16px Arial";
						ctx.fillText(this.options.title, centerX + 0, 16 + 15 + 0);
					}
					ctx.restore();
					return ctx;
				}

				frameUpdate(frameCountMax = 0, frameCount = 0) {
					this.recorder.add(this.frame(frameCount * 13.3));
					this.onUpdate({ frame: frameCount, frames: frameCountMax });
					if(frameCount == 0 || (frameCount / frameCountMax < 1)) {
						requestAnimationFrame(this.frameUpdate.bind(this, frameCountMax, frameCount + 1));
					} else {
						requestAnimationFrame(this.frameUpdateFinish.bind(this));
					}
				}

				frameUpdateFinish() {
					if (this.onFinishWithRecord) {
						this.onFinishWithRecord();
					} else {
						this.finish = true;
						this.onFinish();
					}
				}

				frameRecordFinish(output) {
					let url = (window.webkitURL || window.URL).createObjectURL(output);
					this.onRecordFinish({ url, output });
					this.finish = true;
					this.onFinish();
				}
			}
    </script>
	<script type="text/javascript">
    	const form = document.getElementById('form');
    	const roulette = RouletteCanvas.install(document.getElementById('canvas'), {
    		onStart() {
    			Array.prototype.forEach.call(form.elements, (element) => element.disabled = element.readOnly = true);
    		},
    		onFinish() {
    			Array.prototype.forEach.call(form.elements, (element) => element.disabled = element.readOnly = false);
    		},
    		onRecordFinish(e) {
    			const anchor = document.createElement('a');
    			anchor.download = `roulette-generator-${Date.now()}.webm`;
    			anchor.href = e.url;
    			anchor.click();
    		},
    	});
    	
    	form.addEventListener('submit', (e) => {
    		e.preventDefault();
    		roulette.render({
    			title: form.title.value, 
    			values: form.values.value,
    			background: form.background.value,
    		}, form.record.checked);
    	});
    </script>
</body>
</html>