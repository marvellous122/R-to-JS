// -*- C++ -*-

#ifndef _POMP_INTERNAL_H_
#define _POMP_INTERNAL_H_

#include <R.h>
#include <Rmath.h>
#include <Rdefines.h>
#include <Rinternals.h>

#include "pomp_defines.h"

typedef enum {dflt=0,onestep=1,discrete=2,euler=3,gill=4} rprocmode;

// PROTOTYPES
// Make with, e.g.,
// cproto -I `R RHOME`/include -e *.c | perl -pe 's/\/\*(.+?)\*\//\n\/\/$1/g'

// bspline.c 
extern SEXP bspline_basis(SEXP x, SEXP nbasis, SEXP degree, SEXP deriv);
extern SEXP periodic_bspline_basis(SEXP x, SEXP nbasis, SEXP degree, SEXP period, SEXP deriv);
extern void periodic_bspline_basis_eval(double x, double period, int degree, int nbasis, double *y);
extern void periodic_bspline_basis_eval_deriv(double x, double period, int degree, int nbasis, int deriv, double *y);

// distributions.c 
extern SEXP R_Euler_Multinom(SEXP n, SEXP size, SEXP rate, SEXP Rf_dt);
extern SEXP D_Euler_Multinom(SEXP x, SEXP size, SEXP rate, SEXP Rf_dt, SEXP log);
extern SEXP R_GammaWN(SEXP n, SEXP sigma, SEXP deltat);

// dmeasure.c 
extern SEXP do_dmeasure(SEXP object, SEXP y, SEXP x, SEXP times, SEXP params, SEXP log, SEXP gnsi);

// dprior.c 
extern SEXP do_dprior(SEXP object, SEXP params, SEXP log, SEXP gnsi);

// dprocess.c 
extern SEXP do_dprocess(SEXP object, SEXP x, SEXP times, SEXP params, SEXP log, SEXP gnsi);

// euler.c 
extern SEXP euler_model_simulator(SEXP func, SEXP xstart, SEXP times, SEXP params, double deltat, rprocmode method, SEXP accumvars, SEXP covar, SEXP args, SEXP gnsi);
extern int num_euler_steps(double t1, double t2, double *Rf_dt);
extern int num_map_steps(double t1, double t2, double Rf_dt);

// gompertz.c 
extern void _gompertz_normal_dmeasure(double *lik, double *y, double *x, double *p, int give_log, int *obsindex, int *stateindex, int *parindex, int *covindex, double *covars, double t);
extern void _gompertz_normal_rmeasure(double *y, double *x, double *p, int *obsindex, int *stateindex, int *parindex, int *covindex, double *covars, double t);
extern void _gompertz_simulator(double *x, const double *p, const int *stateindex, const int *parindex, const int *covindex, int covdim, const double *covar, double t, double Rf_dt);
extern void _gompertz_skeleton(double *f, double *x, const double *p, const int *stateindex, const int *parindex, const int *covindex, const double *covar, double t);
extern void _gompertz_to_trans(double *__pt, const double *__p, const int *__parindex);
extern void _gompertz_from_trans(double *__p, const double *__pt, const int *__parindex);

// init.c 
extern void R_init_pomp2(DllInfo *info);

// lookup_table.c 
extern SEXP get_covariate_names(SEXP object);
extern lookup_table_t make_covariate_table(SEXP object, int *ncovar);
extern SEXP lookup_in_table(SEXP covar, SEXP t);
extern void table_lookup(lookup_table_t *tab, double x, double *y);

// mif2.c 
extern SEXP randwalk_perturbation(SEXP params, SEXP rw_sd);

// ou2.c 
extern void _ou2_step(double *x, const double *p, const int *stateindex, const int *parindex, const int *covindex, int ncov, const double *covars, double t, double Rf_dt);
extern void _ou2_pdf(double *f, double *x, double *z, double t1, double t2, const double *p, const int *stateindex, const int *parindex, const int *covindex, const double *covars);
extern void _ou2_skel(double *f, double *x, double *p, int *stateindex, int *parindex, int *covindex, double *covars, double t);
extern void _ou2_dmeasure(double *lik, double *y, double *x, double *p, int give_log, int *obsindex, int *stateindex, int *parindex, int *covindex, double *covar, double t);
extern void _ou2_rmeasure(double *y, double *x, double *p, int *obsindex, int *stateindex, int *parindex, int *covindex, double *covar, double t);

// partrans.c 
extern SEXP do_partrans(SEXP object, SEXP params, SEXP dir, SEXP gnsi);

// pfilter.c 
extern SEXP pfilter_computations(SEXP x, SEXP params, SEXP Np, SEXP predmean, SEXP predvar, SEXP filtmean, SEXP trackancestry, SEXP doparRS, SEXP weights, SEXP tol);

// pomp_fun.c 
extern SEXP pomp_fun_handler(SEXP pfun, SEXP gnsi, pompfunmode *mode, SEXP S, SEXP P, SEXP O, SEXP C);
extern SEXP load_stack_incr(SEXP pack);
extern SEXP load_stack_decr(SEXP pack);

// probe_acf.c 
extern SEXP probe_acf(SEXP x, SEXP lags, SEXP corr);
extern SEXP probe_ccf(SEXP x, SEXP y, SEXP lags, SEXP corr);

// probe.c 
extern SEXP apply_probe_data(SEXP object, SEXP probes);
extern SEXP apply_probe_sim(SEXP object, SEXP nsim, SEXP params, SEXP probes, SEXP datval, SEXP gnsi);

// probe_marginal.c 
extern SEXP probe_marginal_setup(SEXP ref, SEXP order, SEXP diff);
extern SEXP probe_marginal_solve(SEXP x, SEXP setup, SEXP diff);

// probe_nlar.c 
extern SEXP probe_nlar(SEXP x, SEXP lags, SEXP powers);

// resample.c 
extern void nosort_resamp(int nw, double *w, int np, int *p, int offset);
extern SEXP systematic_resampling(SEXP weights);

// rinit.c 
extern SEXP do_rinit(SEXP object, SEXP params, SEXP t0, SEXP nsim, SEXP gnsi);

// rmeasure.c 
extern SEXP do_rmeasure(SEXP object, SEXP x, SEXP times, SEXP params, SEXP gnsi);

// rprior.c 
extern SEXP do_rprior(SEXP object, SEXP params, SEXP gnsi);

// rprocess.c 
extern SEXP do_rprocess(SEXP object, SEXP xstart, SEXP times, SEXP params, SEXP offset, SEXP gnsi);

// simulate.c 
extern SEXP do_simulate(SEXP object, SEXP params, SEXP nsim, SEXP rettype, SEXP gnsi);

// skeleton.c 
extern SEXP add_skel_args(SEXP args, SEXP Snames, SEXP Pnames, SEXP Cnames);
extern void eval_skeleton_R(double *f, double *time, double *x, double *p, SEXP fn, SEXP args, SEXP Snames, int nvars, int npars, int ncovars, int ntimes, int nrepx, int nrepp, int nreps, lookup_table_t *covar_table);
extern void iterate_skeleton_R(double *X, double t, double deltat, double *time, double *x, double *p, SEXP fn, SEXP args, SEXP Snames, int nvars, int npars, int ncovars, int ntimes, int nrepp, int nreps, int nzeros, lookup_table_t *covar_table, int *zeroindex);
extern void eval_skeleton_native(double *f, double *time, double *x, double *p, int nvars, int npars, int ncovars, int ntimes, int nrepx, int nrepp, int nreps, int *sidx, int *pidx, int *cidx, lookup_table_t *covar_table, pomp_skeleton *fun, SEXP args);
extern void iterate_skeleton_native(double *X, double t, double deltat, double *time, double *x, double *p, int nvars, int npars, int ncovars, int ntimes, int nrepp, int nreps, int nzeros, int *sidx, int *pidx, int *cidx, lookup_table_t *covar_table, int *zeroindex, pomp_skeleton *fun, SEXP args);
extern SEXP do_skeleton(SEXP object, SEXP x, SEXP t, SEXP params, SEXP gnsi);

// sobolseq.c 
extern SEXP sobol_sequence(SEXP dim, SEXP length);

// ssa.c 
extern SEXP SSA_simulator(SEXP func, SEXP xstart, SEXP times, SEXP params, SEXP vmatrix, SEXP covar, SEXP accumvars, SEXP hmax, SEXP args, SEXP gnsi);

// synth_lik.c 
extern SEXP synth_loglik(SEXP ysim, SEXP ydat);

// trajectory.c 
extern SEXP iterate_map(SEXP object, SEXP times, SEXP t0, SEXP x0, SEXP params, SEXP gnsi);
extern SEXP pomp_desolve_setup(SEXP object, SEXP x0, SEXP params, SEXP gnsi);
extern void pomp_vf_eval(int *neq, double *t, double *y, double *ydot, double *yout, int *ip);
extern void pomp_desolve_takedown(void);

// transformations.c 
extern SEXP LogitTransform(SEXP P);
extern SEXP ExpitTransform(SEXP X);
extern SEXP LogBarycentricTransform(SEXP X);
extern SEXP InverseLogBarycentricTransform(SEXP Y);

// userdata.c 
extern void set_pomp_userdata(SEXP userdata);
extern const SEXP get_userdata(const char *name);
extern const int *get_userdata_int(const char *name);
extern const double *get_userdata_double(const char *name);
extern void unset_pomp_userdata(void);

#endif
