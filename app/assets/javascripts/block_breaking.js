$(function() {
	var ctx,
		myPaddle,
		myBall,
		keyX,
		score,
		scoreLabel,
		isPlaying = false,
		timerId;

	var blocks = [];
	var row = 3;
    var col = 8;

	var canvas = document.getElementById('mycanvas');
	if (!canvas || !canvas.getContext) return false;
	ctx = canvas.getContext('2d');

	//スコア
	var Label = function(x, y) {
		this.x = x;
		this.y = y;
		this.draw = function(text) {
			ctx.font = 'bold 14px "Century Gothic"';
			ctx.fillStyle = '#00AAFF';
			ctx.textAlign = 'left';
			ctx.fillText(text, this.x, this.y);
		}
	}

	//ボールの管理
	var Ball = function(x, y, vx, vy, r) {
		this.x = x;
		this.y = y;
		this.vx = vx;
		this.vy = vy;
		this.r = r;
		this.draw = function() {
			ctx.beginPath();
			ctx.fillStyle = '#FF0088';
			ctx.arc(this.x, this.y, this.r, 0, 2*Math.PI, true);
			ctx.fill();
		};
		this.move = function () {
			this. x += this.vx;
			this. y += this.vy;
			//左端 or 右端の壁にあたったら
			if (this.x + this.r > canvas.width || this.x - this.r < 0) {
				this.vx *= -1;
			}
			//上の壁にあたったら
			if (this.y - this.r < 0) {
				this.vy *= -1;
			}
			//下の壁にあたったら
			if (this.y + this.r > canvas.height) {
				// alert("game over");
				isPlaying = false;
				$('#btn').text('REPLAY?').fadeIn();
				ctx.font = "48px serif";
  				ctx.fillText("Game Over!", 60, canvas.height / 2);
			}
		};

		//パドルの当たり判定
		this.checkPaddleCollision = function(paddle) {
			//パドルの左外側にあたったら
			if ((this.y + this.r > paddle.y && this.y + this.r < paddle.y + paddle.h) &&
				(this. x > paddle.x - paddle.w / 2 && this.x < paddle.x - paddle.w / 4)) {
				score++;
				if (Math.sign(this.vx) === -1) {
					this.vy *= -1;
					this.vx *= 1.5;
				} else if(Math.sign(this.vx) === 1) {
					this.vy *= -1;
					this.vx *= -1.5;
				}

				if (score % 3 === 0) {
				 	this.vx *= 1.2;
				 	paddle.w *= 0.95;
				}

			//パドルの左内側にあたったら
			} else if ((this.y + this.r > paddle.y && this.y + this.r < paddle.y + paddle.h) &&
				(this.x > paddle.x - paddle.w / 4 && this.x < paddle.x)) {
				score++;
				if (Math.sign(this.vx) === -1) {
					this.vy *= -1;
					this.vx *= 0.8;
				} else if(Math.sign(this.vx) === 1) {
					this.vy *= -1;
					this.vx *= -0.8;
				}

				if (score % 3 === 0) {
				 	this.vx *= 1.2;
				 	paddle.w *= 0.95;
				}

			//パドルの右内側にあたったら
			} else if ((this.y + this.r > paddle.y && this.y + this.r < paddle.y + paddle.h) &&
				(this. x < paddle.x + paddle.w / 4 && this.x > paddle.x)) {
				score++;
				if (Math.sign(this.vx) === -1) {
					this.vy *= -1;
					this.vx *= -0.8;
				} else if(Math.sign(this.vx) === 1) {
					this.vy *= -1;
					this.vx *= 0.8;
				}

				if (score % 3 === 0) {
				 	this.vx *= 1.2;
				 	paddle.w *= 0.95;
				}

			//パドルの右外側にあたったら
			} else if ((this.y + this.r > paddle.y && this.y + this.r < paddle.y + paddle.h) &&
				(this. x < paddle.x + paddle.w / 2 && this.x > paddle.x + paddle.w / 4)) {
				score++;
				if (Math.sign(this.vx) === -1) {
					this.vy *= -1;
					this.vx *= -1.5;
				} else if(Math.sign(this.vx) === 1) {
					this.vy *= -1;
					this.vx *= 1.5;
				}

				if (score % 3 === 0) {
				 	this.vx *= 1.2;
				 	paddle.w *= 0.95;
				}
			}
		}

		// ブロック当たり判定
	    this.checkBlockCollusion = function(block) {
	    	if (block.flag == true) {
                // 左からヒット
                if (this.x + this.r >= block.x && this.x + this.r <= block.x + block.w && this.y >= block.y && this.y <= block.y + block.h) {
                    this.vx *= -1;
                    block.flag = false;
                    score += 5;
                }
                // 右からヒット
                if (this.x - this.r >= block.x && this.x - this.r <= block.x + block.w && this.y >= block.y && this.y <= block.y + block.h) {
                    this.vx *= -1;
                    block.flag = false;
                    score += 5;
                }
                // 上からヒット
                if (this.y + this.r >= block.y && this.y + this.r <= block.y + block.h && this.x <= block.x + block.w && this.x >= block.x) {
                    this.vy *= -1;
                    block.flag = false;
                    score += 10;
                }
                // 下からヒット
                if (this.y - this.r >= block.y && this.y - this.r <= block.y + block.h && this.x <= block.x + block.w && this.x >= block.x) {
                    this.vy *= -1;
                    block.flag = false;
                    score += 1;
                }
            }
	    }
	};

	//パドルの管理
	var Paddle = function(w, h) {
		this.w = w;
		this.h = h;
		this.x = canvas.width / 2;
		this.y = canvas.height - 30;
		this.draw = function() {
			ctx.fillStyle = '#00AAFF';
			ctx.fillRect(this.x - this.w / 2, this.y, this.w, this.h);
		};

		//パドルの動き管理
		this.move = function() {
			// console.log(keyX);
			if (keyX === 39) {
				if (this.x + this.w / 2 > canvas.width) {
					return;
				}
				this.x += 20;
			} else if (keyX === 37) {
				if (this.x - this.w / 2 < 0) {
					return;
				}
				this.x -= 20;
			}
		}
	};

	//ブロックの管理
	function Block() {
	    this.initialize.apply(this, arguments);
	}
	Block.prototype = {
	    x: 0,
	    y: 0,
	    w: 0,
	    h: 0,
	    flag: true,
	    // コンストラクタ
	    initialize: function (option) {
	        this.x = option.x;
	        this.y = option.y;
	        this.w = option.w;
	        this.h = option.h;
	    },
	    // 描画
	    draw: function () {
	        if (this.flag) {
	            ctx.fillStyle = '#ff0000';
	            ctx.fillRect(this.x, this.y, this.w, this.h);
	            ctx.strokeStyle = '#aa0000';
	            ctx.strokeRect(this.x, this.y, this.w, this.h);
	        }
	    }
	};

	// ブロックの初期化
	function initBlocks() {
	    for (var i = 0; i < row; i++) {
	        for (var j = 0; j < col; j++) {
	            blocks[i * col + j] = new Block({
	                x: j * (canvas.width / col),
	                y: i * 20,
	                w: (canvas.width / col),
	                h: 20
	            });
	        }
	    }
	    return blocks;
	}

	//ボールの横方向速度の乱数化
	function rand(min, max) {
		return Math.floor(Math.random() * (max- min + 1)) + min;
	}

	//初期化
	function init(){
		score = 0;
		isPlaying = true;
		myPaddle = new Paddle(100, 10);
		myBall = new Ball(canvas.width / 2, canvas.height - 40, rand(3, 8), 4, 6);
		scoreLabel = new Label(10, canvas.height - 5);
		scoreLabel.draw('SCORE: ' + score);
	}

	//一度キャンバス書き直し。これがないと移動しているように見えない
	function clearStage() {
		ctx.fillStyle = '#AAEDFF';
		ctx.fillRect(0, 0, canvas.width, canvas.height);
	}

	//0.03sごとに描画を更新
	function update() {
		clearStage();
		scoreLabel.draw('SCORE: ' + score);
		myPaddle.draw();
		myBall.draw();
		var flag = true;		//クリア判定。falseでクリア
		for (var i = 0; i < row; i++) {
            for (var j = 0; j < col; j++) {
                blocks[i * col + j].draw();			//ブロック描画
                myBall.checkBlockCollusion(blocks[i * col + j]);
                if (blocks[i * col + j].flag) {			//ブロックが全て消えたらクリア
                    flag = false;
                }
            }
        }
		myBall.move();
		myBall.checkPaddleCollision(myPaddle);
		if (flag) {
			isPlaying = false;
			setTimeout(function() {
				ctx.font = "48px serif";
	  			ctx.fillStyle = '#0F0';
	  			ctx.fillText("Game Crear!", 60, canvas.height / 2);
	  			ctx.fillStyle = '#000';
	  			ctx.strokeText("Game Crear!", 60, canvas.height / 2);
	  			$('#btn').text('REPLAY?').fadeIn();
			}, 100);
		}
		timerId = setTimeout(function() {
			update();
		}, 30);
		if (!isPlaying) clearTimeout(timerId);
	}

	$('#btn').click(function() {
		$(this).fadeOut();
		init();
		initBlocks()
		update();
	});

	$('body').keydown(function(e) {
		keyX = e.keyCode;
		if (isPlaying) myPaddle.move();
	});
});



