# تعديلات المتسابق رقم 27 لقد وضعت نظام الاسكور الي خو عدد الاوراق المفقوده 
extends CharacterBody2D

class_name enemy_1

@onready var comic_lap: Label = $comiclab
@onready var flow: Enemy_1_Flow = $FSM/Flow
@onready var fsm: FiniteStateMachine = $FSM
@onready var shap_cast: ShapeCast2D = $Enemy_animation/shapCast2D
@onready var detection_area: Area2D = $DetectionArea  # يجب أن تكون منطقة كشف داخل العدو

var hp := 5
var has_shown_comment := false  # لضمان عدم تكرار الجملة

# قائمة الجمل الساخرة
var sarcastic_phrases := [
	"المطور 25 كان يريد إضافة أسلحة نارية... لكنه استسلم عند أول مشكلة!",
	"أين الأسلحة الحديثة؟ آه صحيح، المطور 25 قرر أن الإضاءة أكثر أهمية!",
	"هل كنت تنتظر AK-47؟ عذرًا، المطور 25 خذلنا جميعًا!",
	"لا أسلحة؟ لا مشكلة، لكن لماذا أضاف المطور 25 منصة تتحرك بلا سبب؟",
	"تخيلت أنني سأواجه لاعبًا بسلاح ناري... لكن المطور 25 قال لا!",
	"سمعت أن المطور 25 حاول إضافة شيء ثوري... انتهى به الأمر بإضافة إضاءة!",
	"أنا مجرد عدو، لكن حتى أنا أشعر بخيبة أمل من المطور 25!",
	"لحظة... من الذي برمجني؟ المطور 25؟ حسنًا، هذا يفسر كل شيء!",
	"المطور 25 كان لديه 17 ساعة... وأفضل ما فعله هو إضافة منصة؟",
	"واو، تحديث جديد! دعني أخمن... لم يتم إضافة شيء مفيد مجددًا؟",
	"أعتقد أن المطور 25 نسي أن هذه لعبة وليس عرض إضاءة!",
	"كنت أتوقع معركة ملحمية، لكن يبدو أن المطور 25 لم يكن مستعدًا لهذا!",
	"أشعر وكأنني في مسرحية، والمطور 25 هو الكاتب الذي لا يعرف ماذا يفعل!"
]

func _ready():
	if detection_area:
		detection_area.body_entered.connect(_on_player_detected)  # ربط منطقة الكشف بالكود

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector2(0, 980) * delta  # الجاذبية

	die()
	move_and_slide()

	if shap_cast.is_colliding():
		velocity.y = -200

func die():
	if hp <= 0:
		fsm.force_change_state("Death")
		if Global.coin < 50:
			Global.coin += 1
		Global.score += randi_range(1 , 10) / 6 

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage(1)
		body.knockback(sign(body.global_position.x - global_position.x))
		Global.camera.shake(1, 0.2)
		await get_tree().create_timer(1).timeout
		reset_attack()

func knockback(dir, amount = 1):
	$FSM/KnockBack.dir = dir
	$FSM/KnockBack.amount = amount
	$FSM.current_state.state_transition.emit($FSM.current_state, "KnockBack")

func reset_attack():
	$"Attack area".set_deferred("monitoring", false)
	await get_tree().create_timer(0.1).timeout
	$"Attack area".set_deferred("monitoring", true)

func damage(value):
	hp -= value
	$Enemy_animation.modulate = Color(1, 0, 0)  # تأثير الضرر باللون الأحمر
	await get_tree().create_timer(0.1).timeout
	$Enemy_animation.modulate = Color(1, 1, 1)

# عرض الجملة الساخرة عند رؤية اللاعب
func show_sarcastic_comment():
	if has_shown_comment or not comic_lap:
		return  # لا تعرض الجملة أكثر من مرة

	has_shown_comment = true
	comic_lap.text = sarcastic_phrases[randi() % sarcastic_phrases.size()]
	comic_lap.show()

	await get_tree().create_timer(5.0).timeout
	comic_lap.hide()

# عند دخول اللاعب منطقة الكشف
func _on_player_detected(body: Node2D):
	if body.is_in_group("Player"):
		show_sarcastic_comment()
