/* See LICENSE file for copyright and license details. */

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

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask

/* view adjustment */
void
adjustview(const Arg *arg) {
    int newtag = selmon->tagset[selmon->seltags];
    if (arg->i > 0) { /* move right */
        newtag <<= 1;
        if (newtag > (1 << (LENGTH(tags) - 1)))
            newtag = 1;
    } else { /* move left */
        newtag >>= 1;
        if (newtag == 0)
            newtag = 1 << (LENGTH(tags) - 1);
    }
    const Arg a = { .ui = newtag };
    view(&a);
}

void
adjusttag(const Arg *arg) {
    if (!selmon->sel)
        return;

    int curtag = selmon->sel->tags;
    int newtag;

    if (arg->i > 0) { /* move right */
        newtag = curtag << 1;
        if (newtag > (1 << (LENGTH(tags) - 1)))
            newtag = 1;
    } else { /* move left */
        newtag = curtag >> 1;
        if (newtag == 0)
            newtag = 1 << (LENGTH(tags) - 1);
    }

    selmon->sel->tags = newtag;
    view(&(Arg){.ui = newtag});
}

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_bg, "-nf", col_dim, "-sb", col_highlight, "-sf", col_fg, NULL };
static const char *termcmd[]  = { "kitty", NULL };

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
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
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

