/* Generated by            cobc 1.1.0 */
/* Generated from          orbits.cob */
/* Generated at            set 14 2015 22:22:43 CEST */
/* OpenCOBOL build date    Sep 14 2015 19:29:23 */
/* OpenCOBOL package date  Feb 06 2009 10:30:55 CET */
/* Compile command         cobc --free -x -C orbits.cob */

/* Decimal structures */
static cob_decimal d0;
static cob_decimal d1;
static cob_decimal d2;
static cob_decimal d3;
static cob_decimal d4;

/* File ENTRADA */
static cob_file		*h_ENTRADA = NULL;
static unsigned char	h_ENTRADA_status[4];
/* File SORTIDA */
static cob_file		*h_SORTIDA = NULL;
static unsigned char	h_SORTIDA_status[4];

/* Define perform frame stack */

struct cob_frame	*frame_ptr;
struct cob_frame	frame_stack[255];

unsigned char	*b_17 = NULL;	/* R1 */
unsigned char	*b_21 = NULL;	/* R2 */
unsigned char	*b_25 = NULL;	/* V1 */
unsigned char	*b_29 = NULL;	/* V2 */
unsigned char	*b_33 = NULL;	/* A1 */
unsigned char	*b_37 = NULL;	/* A2 */
unsigned char	*b_41 = NULL;	/* W */
unsigned char	*b_45 = NULL;	/* G */
unsigned char	*b_46 = NULL;	/* I */
unsigned char	*b_47 = NULL;	/* M1 */
unsigned char	*b_48 = NULL;	/* M2 */
unsigned char	*b_49 = NULL;	/* R */
unsigned char	*b_50 = NULL;	/* COEF */
unsigned char	*b_51 = NULL;	/* DT */
unsigned char	*b_52 = NULL;	/* NINCR */
unsigned char	*b_53 = NULL;	/* SW-EOF */
unsigned char	*b_55 = NULL;	/* LIN-CAP1 */
unsigned char	*b_61 = NULL;	/* LIN-CAP2 */
unsigned char	*b_67 = NULL;	/* LIN-DET */
