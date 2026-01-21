
# Adaptive Controllers Design for Systems with Input Constraints

This repository contains a practical project on **adaptive controller design under input constraints** (actuator saturation), following Adaptive and Robust Control approach with a project report implementation focused on MRAC with saturation.
The core study evaluates how saturation affects tracking, stability/boundedness, and parameter convergence.Especially when persistent excitation (PE) is weak and demonstrates why the Lion MRAC scheme is more robust than a basic gradient MRAC in this setting. 

## Project scope
Adaptive controllers often assume the computed control (u*) can be applied directly, but real actuators saturate: u = sat(u*).
This project studies MRAC performance with explicit saturation constraints and documents simulation results comparing saturated vs unsaturated operation, emphasizing:  
- Tracking error convergence and bounded signals under saturation. 
- Practical limitations on parameter identification when excitation is not persistently rich (parameter convergence vs mere boundedness). 
- The benefits of the Lion adaptation scheme (dynamic regressor extension + normalization) for handling distortion introduced by saturation. 

## System and control objective
### Plant (project report setup)
A second-order plant is used, with parameters \(a_0=1\), \(a_1=3\), \(b_0=3\), yielding a stable but relatively slow/oscillatory baseline response. 
The problem is to design an adaptive controller such that the plant output \(y(t)\) tracks a stable second-order reference model output \(y_m(t)\). 

### Reference model
The report uses a stable second-order reference model (double poles at \(-1\)) and tests two reference inputs: a discontinuous switching-type signal and a smooth sinusoidal signal to probe excitation richness and convergence behavior. 

### Input constraint
A saturated actuator applies a bounded version of the commanded input, so the actual control \(u(t)\) is clipped between specified minimum and maximum limits, while an unsaturated case applies the commanded control directly without clipping.

## Methods implemented
### Lion MRAC with saturation handling
The main implementation uses the Lion MRAC idea, combining:  
- Dynamic Regressor Extension (DRE): multiple stable filters applied to regressors to improve excitation richness. 
- Normalization of adaptation gain: reduces sensitivity to large regressor magnitudes and supports stable adaptation behavior. 
- MRAC tracking objective: drive \(e(t)=y_m(t)-y(t)\) toward zero while maintaining bounded internal signals. 

### Why Lion vs basic gradient MRAC (project takeaway)
The highlights is that, under saturation, the Lion scheme maintains fast tracking convergence and bounded estimates, while gradient-based schemes can fail to converge under the same constraints; Lion’s DRE helps compensate for saturation-induced distortion in the regressor/error relationship. 

## Results summary 
Key observed behaviors in the report’s simulations:  
- Tracking error converges quickly in both unsaturated and saturated cases, settling into small oscillations around zero; saturation does not prevent convergence for Lion MRAC in these experiments. 
- Parameter estimates remain bounded but may not converge to true values (for example, the input gain estimate stabilizing below the true \(b_0\)), attributed to limited excitation (lack of PE) and reduced control authority due to saturation. 
- The control signal frequently hits the saturation limit in transients, illustrating the practical mismatch between ideal MRAC control \(u^\*\) and applied control \(\mathrm{sat}(u^\*)\).

## Repository structure 

- `report/`  
  - `Adaptive_controller_design.pdf` (project report) 
- `simulink/`  
  - Simulink models (Gradient and Lion scheme  saturated and unsaturated variants) 
- `matlab/`  
  - S-functions / scripts for the Lion MRAC update law used by Simulink 
- `results/`  
  - Exported plots (tracking error, parameter estimates, control signals) and logged data 
- `docs/`  
  - Notes on equations, parameter choices, and reproduction steps (brief, non-duplicative) 

## How to run 
1. Install MATLAB/Simulink (version used in your environment) and ensure required toolboxes for S-functions (if applicable) are available. 
2. Open the Simulink models:
   - Unsaturated Lion MRAC model (baseline). 
   - Saturated Lion MRAC model with \(u\in[0,2]\) constraint. 
3. Run simulations and verify outputs:
   - Tracking error \(e(t)=y_m(t)-y(t)\). 
   - Parameter estimate trajectories (estimated input gain). 
   - Control signals: computed \(u^\*(t)\) vs saturated \(u(t)\). 

## Learning objectives 
- How actuator saturation changes MRAC behavior and can prevent ideal tracking/identification assumptions from holding exactly. 
- Why “boundedness + good tracking” can still occur even when parameter convergence fails (insufficient PE and constrained control authority). 
- Practical application of concepts: adaptive control with input constraints and Lion scheme for improved convergence properties.

## Citation / academic context
- Gerasimov, D. (2024). Adaptive and Robust Control: Practical Course. Saint Petersburg.
- Lion, P. M. (1967). Rapid Identification of Linear and Nonlinear Systems. AIAA Journal.
- Ioannou, P. A., & Sun, J. (1996). Robust Adaptive Control. Prentice-Hall.

