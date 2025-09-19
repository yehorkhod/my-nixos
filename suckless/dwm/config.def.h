// "shotgun /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png"
// "shotgun -g $(slop) /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png"
// "pamixer -d 10"
// "pamixer -i 10"
// "pamixer -t"
// "brightnessctl s 10%+"
// "brightnessctl s 10%-"
// super + o
// move to st and surf
// move windows up and down
// super + p
// battery and time on top bar
#define MODKEY Mod4Mask
static const char *tags[] = { "1", "2", "3", "4", "5" };
static const Rule rules[] = { 0 };
static const char *autostart[] = {
    "feh --bg-fill /home/yehorkhod/wallpaper.png",
    "setxkbmap -layout us,ua -option grp:win_space_toggle",
    NULL
};

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "FiraCode Nerd Font:size=14" };
static const char dmenufont[]       = "FiraCode Nerd Font:size=14";
static const char col_bg[]          = "#232136";
static const char col_fg[]          = "#e0def4";
static const char col_dim[]         = "#6e6a86";
static const char col_highlight[]   = "#9ccfd8";
static const char col_border[]      = "#31748f";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
    [SchemeNorm] = { col_dim,   col_bg,    col_bg },
    [SchemeSel]  = { col_fg,    col_bg,    col_highlight },
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;
static const int resizehints = 1; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;
static const Layout layouts[] = { { "[]=", tile }, { "><>", NULL }, { "[M]", monocle } };

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_bg, "-nf", col_dim, "-sb", col_bg, "-sf", col_highlight, NULL };
static const char *termcmd[]  = { "kitty", NULL };

/* key definitions */
static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },

	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_c,      killclient,     {0} },

	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },

	{ MODKEY,                       XK_l,      adjustview,     {.i = +1 } },
	{ MODKEY,                       XK_h,      adjustview,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_l,      adjusttag,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_h,      adjusttag,      {.i = -1 } },

	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },

	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

