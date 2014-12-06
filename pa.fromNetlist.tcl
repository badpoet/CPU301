
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name cpu301 -dir "C:/COA/cpu301/planAhead_run_4" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/COA/cpu301/TEST_BENCH.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/COA/cpu301} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "TEST_BENCH.ucf" [current_fileset -constrset]
add_files [list {TEST_BENCH.ucf}] -fileset [get_property constrset [current_run]]
link_design
