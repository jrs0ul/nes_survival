; CONSTANTS
    ZERO_SPRITE                = $0200
    FIRST_SPRITE               = $0204

    ;possible game states
    STATE_TITLE                = 0
    STATE_GAME                 = 1
    STATE_MENU                 = 2
    STATE_GAME_OVER            = 3
    STATE_INTRO                = 4
    STATE_OUTRO                = 5

    BUTTON_RIGHT_DOWN_MASK     = %00000101
    BUTTON_RIGHT_UP_MASK       = %00001001
    BUTTON_LEFT_DOWN_MASK      = %00000110
    BUTTON_LEFT_UP_MAK         = %00001010

    BUTTON_RIGHT_MASK          = %00000001
    BUTTON_LEFT_MASK           = %00000010
    BUTTON_DOWN_MASK           = %00000100
    BUTTON_UP_MASK             = %00001000

    BUTTON_START_MASK          = %00010000
    BUTTON_SELECT_MASK         = %00100000

    BUTTON_B_MASK              = %01000000
    BUTTON_A_MASK              = %10000000


    ARGUMENT_STACK_HI          = $fd
    ARGUMENT_STACK_LO          = $07


    PROJECTILE_MAX_COUNT       = 10

    NPC_MAX_COUNT              = 16

    NPC_AGITATION_BIT          = %00001000 ; is this npc agitated
    NPC_DAMAGED_BIT            = %00000100 ; is this npc damaged

.if FAMISTUDIO_CFG_PAL_SUPPORT
    NPC_SPEED                  = 1
    NPC_SPEED_FRACTION         = 44
    NPC_SPEED_AGITATED         = 1
    NPC_SPEED_AGITATED_FRACTION= 154

    NPC_SPEED_DIAG                   = 0
    NPC_SPEED_DIAG_FRACTION          = 212
    NPC_SPEED_AGITATED_DIAG          = 1
    NPC_SPEED_AGITATED_DIAG_FRACTION = 34

.else
    NPC_SPEED                  = 0
    NPC_SPEED_FRACTION         = 250
    NPC_SPEED_AGITATED         = 1
    NPC_SPEED_AGITATED_FRACTION= 128

    NPC_SPEED_DIAG                   = 0
    NPC_SPEED_DIAG_FRACTION          = 177
    NPC_SPEED_AGITATED_DIAG          = 1
    NPC_SPEED_AGITATED_DIAG_FRACTION = 16
.endif

    MAX_SPRITE_COUNT           = 64

    MAX_V_SCROLL               = 255

    MAX_QUEST                  = 4


    NUM_OF_BUNNIES_BEFORE_DOG  = 3

    ROW_TABLE_SIZE             = 240 ;4 screens * 32 rows * 2

    DESTRUCTIBLE_DOOR_IDX      = 3

    DESTRUCTIBLE_OBJECTS_COUNT = 9

    PROJECTILE_TILE            = $37

    ICE_TILE_A                 = $68
    ICE_TILE_B                 = $69
    FIRE_TILE                  = $80


    ROCK_TILE_1                = $DE
    ROCK_TILE_2                = $DF
    ROCK_TILE_3                = $EE
    ROCK_TILE_4                = $EF


    INTRO_SCENE_MAX            = 7
    OUTRO_SCENE_MAX            = 4

    IMPORTANT_ITEM_TIME        = 96


    DAYTIME_NIGHT              = $40

    HOURS_MAX                  = 240
    MINUTES_MAX                = 60
    SLEEP_TIME                 = 60
    COOKING_TIME               = 5
    CRAFTING_TIME              = 6

    PLAYER_ATTACK_DELAY        = 16

    INPUT_DELAY                = 100
    ITEM_DELAY                 = 66
    NPC_AI_DELAY               = 133
    NPC_COLLISION_DELAY        = 255
    FISHING_DELAY              = 2
    STAMINA_DELAY              = 2
    NPC_ELIMINATION_DELAY      = 200

    HUD_TILE_COUNT             = 128
    HUD_TILE_ROW_COUNT         = 4


    PLAYER_COLLISION_LINE_X1   = 3
    PLAYER_COLLISION_LINE_X2   = 13 ;16 - 3
    PLAYER_COLLISION_LINE_Y1   = 8
    PLAYER_WIDTH               = 16
    PLAYER_HEIGHT              = 16
    PLAYER_STAMINA_SIZE        = 128

    PLAYER_DAMAGED_DELAY       = 25 ; how long player remains red when damaged
    PLAYER_OUTLINE_COLOR_POS   = 29 ; black outline postion in sprite palette

.if FAMISTUDIO_CFG_PAL_SUPPORT
    PLAYER_SPEED_WALK_BASE     = 0
    PLAYER_SPEED_WALK_FRACTION = 239
    PLAYER_SPEED_RUN_BASE      = 1
    PLAYER_SPEED_RUN_FRACTION  = 154

    PLAYER_SPEED_DIAG_WALK_BASE     = 0
    PLAYER_SPEED_DIAG_WALK_FRACTION = 169
    PLAYER_SPEED_DIAG_RUN_BASE      = 1
    PLAYER_SPEED_DIAG_RUN_FRACTION  = 34

.else
    PLAYER_SPEED_WALK_BASE     = 0
    PLAYER_SPEED_WALK_FRACTION = 199
    PLAYER_SPEED_RUN_BASE      = 1
    PLAYER_SPEED_RUN_FRACTION  = 128

    PLAYER_SPEED_DIAG_WALK_BASE     = 0
    PLAYER_SPEED_DIAG_WALK_FRACTION = 141 ; sqrt((speed * speed)/2)
    PLAYER_SPEED_DIAG_RUN_BASE      = 1
    PLAYER_SPEED_DIAG_RUN_FRACTION  = 16


.endif

    STAMINA_END_SPRITE         = $39
    STAMINA_SEGMENT_START      = $56 ; lower adress where first stamina segment should be placed
    STAMINA_TILE               = $69

    MAX_TILE_SCROLL_LEFT       = 248; -8
    MAX_TILE_SCROLL_RIGHT      = 8

    ARROW_TILE                 = $38


    SLEEP_POS_X                = 100
    SLEEP_POS_Y                = 72

    SLEEP_ADD_HP_TIMES_TEN     = 3
    SLEEP_SUB_HP_HUNGER_TT     = 5
    SLEEP_SUB_HP_COLD_TT       = 5

    WARMTH_NIGHT_DECREASE      = 5
    WARMTH_DAY_DECREASE        = 1
    WARMTH_COOKING_INCREASE    = 9
    WARMTH_CRAFTING_INCREASE   = 9

    PALETTE_STATE_FADE_OUT     = 1
    PALETTE_STATE_FADE_IN      = 2
    PALETTE_STEP               = $10
    PALETTE_SIZE_MAX           = 32
    PALETTE_FADE_MAX_ITERATION = 5


    OUTDOORS_LOC1_SCREEN_COUNT  = 4
    OUTDOORS_LOC2_SCREEN_COUNT  = 2
    OUTDOORS_LOC3_SCREEN_COUNT  = 2
    OUTDOORS_LOC7_SCREEN_COUNT  = 3 ; cave
    OUTDOORS_LOC8_SCREEN_COUNT  = 3 ; crashsite
    OUTDOORS_LOC9_SCREEN_COUNT  = 3 ; granny's
    OUTDOORS_LOC12_SCREEN_COUNT = 4 ; locations with the mine

    PLAYER_START_X             = $50
    PLAYER_START_Y             = 200


    LOCATION_TYPE_OUTDOORS     = 0
    LOCATION_TYPE_VILLAGER     = 1
    LOCATION_TYPE_HOUSE        = 2
    LOCATION_TYPE_CAVE         = 3
    LOCATION_TYPE_DARK         = 4
    LOCATION_TYPE_ALIEN_BASE   = 5

    LOCATION_FIRST             = 0
    LOCATION_MINE              = 6
    LOCATION_CRASHSITE         = 7
    LOCATION_ALIEN_BASE        = 10
    LOCATION_BOSS_ROOM         = 12
    LOCATION_DARK_CAVE         = 13
    LOCATION_SECRET_CAVE       = 14
    LOCATION_MINE_ROOM         = 15
    LOCATION_DARK_CAVE2        = 16
    LOCATION_ALIEN_BASE_LOBBY  = 17
    LOCATION_PATH_TO_CRASHSITE = 18
    LOCATION_ALIEN_BASE_PRE    = 19

    MAX_LOCATIONS              = 20

    MIN_SCREEN_COUNT_TO_UPDATE = 3


    DAMAGE_RED_BLINK_DURATION  = 5

    COLOR_DARK_RED             = $06
    COLOR_RED                  = $16

    SCREEN_ROW_COUNT           = 30
    SCREEN_COLUMN_COUNT        = 32

    SCREEN_MIDDLE              = 120

    CHARACTER_ZERO             = $01

    MAX_WARMTH_DELAY_OUTSIDE   = 60 ; how fast you lose warmth
    MAX_WARMTH_DELAY_INDOORS   = 16 ; how fast you gain warmth
    MAX_FOOD_DELAY             = 125
    MAX_FUEL_DELAY             = $55

    DECREMENT_FOOD_DEFAULT     = 2

    FIRE_ANIMATION_DELAY       = $20

    COOKING_FUEL_COST          = 5

    SONG_OUTSIDE_DAY           = 0
    SONG_INDOORS               = 1
    SONG_TITLE                 = 2
    SONG_GAME_OVER             = 3
    SONG_DEFEAT                = 4
    SONG_BOSS                  = 5
    SONG_OUTSIDE_NIGHT         = 6
    SONG_ENDING_EVIL           = 7
    SONG_ENDING_GOOD           = 8


    SFX_INVENTORY_FULL         = 4


    INVENTORY_SPRITE_X         = 32
    INVENTORY_SPRITE_MIN_Y     = 68
    INVENTORY_SPRITE_MAX_Y     = 188
    INVENTORY_POINTER_X        = 14
    INVENTORY_STEP_PIXELS      = 12
    BASE_MENU_MIN_Y            = 63  ;pointer position in base action menu
    MENU_ITEM_GRID_ADDRESS     = $03 ; y: 9 * 8
    MENU_TITLE_ADDRESS         = $81
    MENU_ITEM_SPRITE_MIN_Y     = 56
    MENU_SUBMENU_ADDRESS_LOW   = $47
    MENU_SUBMENU_POINTER_X     = 64
    MENU_SUBMENU_POINTER_MIN_Y = 96
    MENU_CRAFT_POINTER_POS     = 58

    ITEM_TYPE_FOOD             = 1
    ITEM_TYPE_FUEL             = 2
    ITEM_TYPE_MEDICINE         = 3
    ITEM_TYPE_MATERIAL         = 4
    ITEM_TYPE_TOOL             = 5
    ITEM_TYPE_CLOTHING         = 6
    ITEM_TYPE_DOCUMENT         = 7

    ITEM_STICK                 = 1
    ITEM_RAW_MEAT              = 2
    ITEM_COOKED_MEAT           = 3
    ITEM_ROWAN_BERRIES         = 4
    ITEM_JAM                   = 5
    ITEM_ROCK                  = 6
    ITEM_SPEAR                 = 7
    ITEM_KNIFE                 = 8
    ITEM_POOP                  = 9
    ITEM_HIDE                  = 10
    ITEM_COAT                  = 11
    ITEM_RAW_JUMBO_MEAT        = 12
    ITEM_COOKED_JUMBO_MEAT     = 13
    ITEM_FISHING_ROD           = 15
    ITEM_RAW_FISH              = 17
    ITEM_COOKED_FISH           = 18
    ITEM_RADIO                 = 19
    ITEM_HAMMER                = 20
    ITEM_WOOD_HAMMER           = 21
    ITEM_SLINGSHOT             = 22
    ITEM_PIE                   = 23
    ITEM_LETTER                = 24
    ITEM_LAMP                  = 26
    ITEM_GRANNYS_HEAD          = 27
    ITEM_KEY                   = 29
    ITEM_MUSHROOM              = 30

    MAX_LETTER_OBJECT_COUNT    = 2


.if FAMISTUDIO_CFG_PAL_SUPPORT
    PROJECTILE_SPEED_INT       = 2
    PROJECTILE_SPEED_FRAC      = 228
.else
    PROJECTILE_SPEED_INT       = 2
    PROJECTILE_SPEED_FRAC      = 190
.endif


    UNUSED                     = 255

    ITEM_COUNT_MAX             = 25

    ITEM_COUNT_LOC1            = 8 ;first location
    ITEM_COUNT_LOC2            = 6
    ITEM_COUNT_LOC3            = 4
    ITEM_COUNT_LOC7            = 3 ; mine
    ITEM_COUNT_LOC8            = 1 ; crashsite
    ITEM_COUNT_LOC9            = 1 ; grany's location
    ITEM_COUNT_LOC12           = 6 ; location where the mine entrance is
    ITEM_COUNT_LOC15           = 5 ; secret cave
    ITEM_COUNT_LOC17           = 6 ; dark cave 2

    ONE_TIME_ITEM_COUNT        = ITEM_COUNT_LOC15 + ITEM_COUNT_LOC8 + ITEM_COUNT_LOC7

    ITEM_NEVER_BEEN_PICKED     = 255

    ITEM_RESPAWN_HOURS         = 90

    ITEM_MAX_HP                = 100

    INVENTORY_MAX_ITEMS        = 10
    INVENTORY_MAX_SIZE         = INVENTORY_MAX_ITEMS * 2

    PROJECTILE_DIR_UP          = 1
    PROJECTILE_DIR_DOWN        = 2
    PROJECTILE_DIR_LEFT        = 3
    PROJECTILE_DIR_RIGHT       = 4

    TOOL_WEAR                  = 10

    NPC_STEPS_BEFORE_REDIRECT  = 16

    NPC_DURATION_ATTACK        = 64
    NPC_DELAY_DAMAGED          = 32

    NPC_IDLE_FRAME             = 32
    NPC_WARNING_FRAME          = 128
    NPC_ATTACK_FRAME           = 160
    NPC_DEATH_FRAME            = 6 * 32
    NPC_DURATION_WARNING       = 10
    NPC_BOSS_DURATION_WARNING  = 30

    NPC_STATE_ATTACK           = 2
    NPC_STATE_WARNING          = 3

    NPC_TYPE_TIMID             = 0
    NPC_TYPE_PREDATOR          = 1
    NPC_TYPE_VILLAGER          = 2
    NPC_TYPE_PASSIVE           = 3
    NPC_TYPE_AGRESSIVE         = 4

    NPC_IDX_DOGMAN             = 0
    NPC_IDX_BUNNY              = 1
    NPC_IDX_BJORN              = 2
    NPC_IDX_HOUND              = 3
    NPC_IDX_ERIKA              = 4
    NPC_IDX_GRANNY             = 5
    NPC_IDX_DEADMAN            = 6
    NPC_IDX_BOAR               = 7
    NPC_IDX_BOSS               = 8

    DIALOG_TEXT_LENGTH         = 96

    RECIPES_SIZE               = 39

    ROT_AMOUNT_RAW_MEAT        = 50
    ROT_AMOUNT_COOKED_MEAT     = 25

    FISHING_CATCH_OFFSET_Y     = 18
    FISHING_BITE_TIMER_MAX     = 15

    CLOTHING_DAMAGE_BY_NPC     = 10

    FADE_DELAY_GAME_OVER       = 3
    FADE_DELAY_GENERIC         = 2
    FADE_DELAY_SLEEP           = 10
    MAX_VILLAGERS              = 4


    SUBMENU_FOOD               = 1
    SUBMENU_STASH_FOOD         = 2
    SUBMENU_ITEM               = 3
    SUBMENU_STASH_ITEM         = 4
    SUBMENU_MATERIAL           = 5
    SUBMENU_STASH_MATERIAL     = 6
    SUBMENU_TOOL               = 7
    SUBMENU_STASH_TOOL         = 8
    SUBMENU_DOCUMENT           = 9
    SUBMENU_STASH_DOCUMENT     = 10
    SUBMENU_SLEEP              = 11

