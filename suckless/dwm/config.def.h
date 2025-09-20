#define MODKEY Mod4Mask
static const char *tags[] = { "1", "2", "3", "4", "5" };
static const Rule rules[] = { 0 };

/* appearance */
static const unsigned int borderpx = 1;
static const unsigned int snap     = 32;
static const int showbar           = 1;
static const int topbar            = 1;
static const char *fonts[]         = { "FiraCode Nerd Font:size=14" };
static const char dmenufont[]      = "FiraCode Nerd Font:size=14";
static const char col_bg[]         = "#232136";
static const char col_fg[]         = "#e0def4";
static const char col_dim[]        = "#6e6a86";
static const char col_highlight[]  = "#9ccfd8";
static const char *colors[][3]     = {
    [SchemeNorm] = { col_dim, col_bg, col_bg },
    [SchemeSel]  = { col_fg,  col_bg, col_highlight },
};

/* layout(s) */
static const float mfact        = 0.55;
static const int nmaster        = 1;
static const int resizehints    = 1;
static const int lockfullscreen = 1;
static const int refreshrate    = 120;
static const Layout layouts[]   = { { "[]=", tile }, { "><>", NULL }, { "[M]", monocle } };

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[]          = { "dmenu_run", "-m", dmenumon, "-l", "5", "-fn", dmenufont, "-nb", col_bg, "-nf", col_dim, "-sb", col_bg, "-sf", col_highlight, NULL };
static const char *incrbrightnesscmd[] = { "brightnessctl", "s", "10%+", NULL };
static const char *decrbrightnesscmd[] = { "brightnessctl", "s", "10%-", NULL };
static const char *incrvolumecmd[]     = { "pamixer", "-i", "10", NULL };
static const char *decrvolumecmd[]     = { "pamixer", "-d", "10", NULL };
static const char *mutevolumecmd[]     = { "pamixer", "-t", NULL };
static const char *fullscreenshotcmd[] = { "sh", "-c", "shotgun /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png" };
static const char *partscreenshotcmd[] = { "sh", "-c", "shotgun -g $(slop) /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png" };
static const char *wallpapercmd[]      = { "feh", "--bg-fill", "/home/yehorkhod/wallpaper.png", NULL };
static const char *layoutcmd[]         = { "setxkbmap", "-layout", "us,ua", "-option", "grp:win_space_toggle", NULL };

/* run on start */
static const char **autostart[] = { wallpapercmd, layoutcmd, NULL };

/* key definitions */
static const Key keys[] = {
    { MODKEY,           XK_d,                     spawn,          { .v = dmenucmd } },
    { 0,                XF86XK_MonBrightnessUp,   spawn,          { .v = incrbrightnesscmd } },
    { 0,                XF86XK_MonBrightnessDown, spawn,          { .v = decrbrightnesscmd } },
    { 0,                XF86XK_AudioRaiseVolume,  spawn,          { .v = incrvolumecmd } },
    { 0,                XF86XK_AudioLowerVolume,  spawn,          { .v = decrvolumecmd } },
    { 0,                XF86XK_AudioMute,         spawn,          { .v = mutevolumecmd } },
    { 0,                XK_Print,                 spawn,          { .v = fullscreenshotcmd } },
    { MODKEY|ShiftMask, XK_s,                     spawn,          { .v = partscreenshotcmd } },

    { MODKEY,           XK_j,                     focusstack,     { .i = +1 } },
    { MODKEY,           XK_k,                     focusstack,     { .i = -1 } },
    { MODKEY|ShiftMask, XK_j,                     movestack,      { .i = +1 } },
    { MODKEY|ShiftMask, XK_k,                     movestack,      { .i = -1 } },

    { MODKEY,           XK_l,                     adjustview,     { .i = +1 } },
    { MODKEY,           XK_h,                     adjustview,     { .i = -1 } },
    { MODKEY|ShiftMask, XK_l,                     adjusttag,      { .i = +1 } },
    { MODKEY|ShiftMask, XK_h,                     adjusttag,      { .i = -1 } },

    { MODKEY,           XK_t,                     setlayout,      { .v = &layouts[0] } },
    { MODKEY,           XK_f,                     setlayout,      { .v = &layouts[1] } },
    { MODKEY,           XK_m,                     setlayout,      { .v = &layouts[2] } },

    { MODKEY,           XK_b,                     togglebar,      { 0 } },
    { MODKEY,           XK_c,                     killclient,     { 0 } },
    { MODKEY|ShiftMask, XK_q,                     quit,           { 0 } },

};

/* button definitions */
static const Button buttons[] = {
    { ClkClientWin, MODKEY, Button1, movemouse,      { 0 } },
    { ClkClientWin, MODKEY, Button2, togglefloating, { 0 } },
    { ClkClientWin, MODKEY, Button3, resizemouse,    { 0 } },
};

