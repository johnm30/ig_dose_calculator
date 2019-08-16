# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

User.create!(name:  "Site Admin",
             email: "john_m_30@hotmail.com",
             password:              "280767",
             password_confirmation: "280767",
             admin: true,
             activated: true,
             activated_at: Time.zone.now
             )
user = User.find_by(name: "Site Admin")
user.microposts.create!(content: "My first post")

# Always include the name in the description for search purposes
Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome",
                criteria: "Specific primary immunodeficiency diagnosis established by a clinical immunologist",
                outcome: "Trough IgG. Reduction in number of infections, treatment courses of antibiotics, days in hospital.")
disease = Disease.find(1)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Primary immunodeficiency",
    description: "Primary immunodeficiencies associated with significant antibody defects (excluding specific antibody deficiency) – long term use"
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome",
                criteria: "Profound B cell depletion and/or significant antibody deficiency",
                outcome: "Trough IgG. Reduction in number of infections, treatment courses of antibiotics, days in hospital.")
disease = Disease.find(2)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Thymoma immunodeficiency",
    description: "Thymoma with immunodeficiency – long term use"
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome",
                criteria: "Patients with primary immunodeficiency having haematopoietic stem cell transplantation (HSCT),
                          preferably when recurrent infections.",
                outcome: "Trough IgG.")
disease = Disease.find(3)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "HSCT in primary immunodeficiencies",
    description: "Patients with primary immunodeficiency having haematopoietic stem cell transplantation (HSCT) – long term use"
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome",
                criteria: "Diagnosed by clinical immunologist. Severe, persistent, opportunistic or recurrent bacterial infections despite continuous oral antibiotic therapy for 6 months,
                          or documented failure of serum antibody response to unconjugated pneumococcal or other polysaccharide vaccine challenge.",
                outcome: "Reduction in number of infections, treatment courses of antibiotics, days in hospital; record pre-treatment and 6 monthly thereafter.")
disease = Disease.find(4)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Specific antibody deficiency (6-12 months)",
    description: "Specific antibody deficiency - use in first 6-12 months."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome",
                criteria: "Diagnosed by clinical immunologist. Severe, persistent, opportunistic or recurrent bacterial infections despite continuous oral antibiotic therapy for 6 months,
                          or documented failure of serum antibody response to unconjugated pneumococcal or other polysaccharide vaccine challenge. Clear evidence of benefit from
                          first 6-12 month trial.",
                outcome: "Reduction in number of infections, treatment courses of antibiotics, days in hospital; record 6 monthly.")
disease = Disease.find(5)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Specific antibody deficiency (beyond 6-12 months)",
    description: "Specific antibody deficiency - long term maintenance after first 6-12 months."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "0.4-0.6 g/kg each month; modified to achieve an IgG trough level of at least the lower limit of the age-specific serum IgG reference range",
                criteria: "Underlying cause of hypogammaglobinaemia cannot be reversed or reversal is contraindicated, or hypogammaglobulinaemia that is drug, HSCT, chronic pulmonary GVHD or malignancy related
                        and associated with recurrent or severe bacterial infection despite continuous oral antibiotic therapy for 6 months, IgG <4 g/L (excluding paraprotein),
                        and (when clinically appropriate) documented failure of serum antibody response to unconjugated pneumococcal or other polysaccharide vaccine challenge.
                        Prophylactic use in B-cell aplasia produced by chimeric antigen recepor T-cell therapy against B-cell antigens.
                        ",
                outcome: "Reduction in number of infections and days in hospital; record pre-treatment and 6 monthly thereafter. Review annually and consider seasonal treatment.")
disease = Disease.find(6)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Secondary antibody deficiency",
    description: "Secondary antibody deficiency - long term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "1 g/kg single dose; second dose if thrombocytopenia persists",
                criteria: "Clinical suspicion of NAIT in the neonatal setting based on clinical features suggestive of bleeding e.g. purpura and/or bruising and/or more serious bleeding and a low platelet count.",
                outcome: "Increment in neonatal platelet count.")
disease = Disease.find(7)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Neonatal alloimmune thrombocytopenia",
    description: "Neonatal alloimmune thrombocytopenia (NAIT)"
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.5-1 g/kg weekly to start at stage of gestation when risk commences and continue throughout pregnancy",
                criteria: "In antenatal setting unexplained previous foetal death, haemorrhage, hydrocephalus or thrombocytopenia or known affected sibling, and maternal platelet-specific alloantibodies directed against current paternal antigens (most commonly HPA1a or HPA-5b).",
                outcome: "No haemorrhage after pregnancy, platelets above 50 x 10^9 / l at time of delivery.")
disease = Disease.find(8)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Fetal-maternal Alloimmune Thrombocytopenia",
    description: "Fetal-maternal Alloimmune Thrombocytopenia (FMAIT)"
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.5 g/kg over 4 hours",
                criteria: "Adjunct to continuous multiple phototherapy in Rhesus or ABO haemolytic disease, when rising bilirubin despite intensive phototherapy.
                          Prevention of foetal haemolytic disease in women with previous history and confirmed red cell antibodies to current paternal or foetal antigens, to delay the need for intrauterine transfusions.",
                outcome: "Bilirubin level. Need for exchange transfusion. Long term morbidity.")
disease = Disease.find(9)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Haemolytic disease of the newborn",
    description: "Haemolytic disease of the newborn - short term use"
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required (2nd dose on emergency list)",
                priority: "1. Red",
                regimen: "1 g/kg single infusion; 2nd dose after 24–48 hours if severe or life-threatening bleeding or after 5-7 days if haemostatically adequate platelet count not achieved",
                criteria: "Life-threatening bleeding, or immediate increase in platelet count is required before emergency surgical procedure or delivery of baby (target count >20 to >100 depending on procedure),
                          or patient haemorrhaging refractory to all other treatment.",
                outcome: "Increase in platelet count, resolution of bleeding, number of bleeding complications.")
disease = Disease.find(10)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Immune Thromocytopenia (ITP) (first dose)",
    description: "Immune Thromocytopenia (ITP) - first dose."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "1 g/kg every 2-3 weeks",
                criteria: "Patient haemorrhaging refractory to all other treatment during period where other treatments are being tried.",
                outcome: "Increase in platelet count, resolution of bleeding, number of bleeding complications.")
disease = Disease.find(11)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Immune Thromocytopenia (ITP) (maintenance)",
    description: "Immune Thromocytopenia (ITP) - maintenance treatment."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1-1.2 g/kg in divided doses; repeated for maximum 2 relapses",
                criteria: "Parvovirus B19 infection confirmed by PCR, with high viral load usually above 109 IU/ml.
                          Foetal hydrops likely associated with parvovirus B19.",
                outcome: "Rise in haemoglobin. Transfusion independence. Reticulocyte count.")
disease = Disease.find(12)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acquired red cell aplasia",
    description: "Acquired red cell aplasia associated with chronic parvovirus B19 infection – short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "1-2 g/kg in divided doses",
                criteria: "Symptomatic or severe anaemia, except in patients with co-morbidities, when steroids failed or contraindicated or prior to splenectory.
                          In pregnancy, for women with warm AHA refractory to corticosteroids or with evidence of fetal anaemia.
                          Neonates of mothers with AHA who have evidence of haemolysis and rising bilirubin despite intensive phototherapy.",
                outcome: "Rise in haemoglobin. Transfusion independence. Reduction in haemolysis markers (bilirubin, lactate dehydrogenase).")
disease = Disease.find(13)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune haemolytic anaemia (first dose)",
    description: "Autoimmune haemolytic anaemia (AHA) including Evans syndrome – first dose."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1-2 g/kg in divided doses",
                criteria: "Symptomatic or severe anaemia, except in patients with co-morbidities, when steroids failed or contraindicated or prior to splenectory.
                          In pregnancy, for women with warm AHA refractory to corticosteroids or with evidence of fetal anaemia.
                          Neonates of mothers with AHA who have evidence of haemolysis and rising bilirubin despite intensive phototherapy.
                          Maximum of 2 repeated courses.",
                outcome: "Rise in haemoglobin. Transfusion independence. Reduction in haemolysis markers (bilirubin, lactate dehydrogenase).")
disease = Disease.find(14)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune haemolytic anaemia (relapse)",
    description: "Autoimmune haemolytic anaemia (AHA) including Evans syndrome – short term use on relapse."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "2 g/kg over 2-5 days with iv methylprednisolone; when preventative, 1-2 g/kg with iv methylprednisolone",
                criteria: "Symptomatic or severe anaemia (Hb <6g/dL, or sometimes higher, with evidence of on-going intravascular haemolysis due to a delayed haemolytic transfusion/hyperhaemolysis).
                          Prevention of above in patients who had a previous reaction or who have single or multiple allo-antibodies and may require a blood transfusion.",
                outcome: "Rise in haemoglobin. Transfusion Independence. Reduction in haemolysis markers (bilirubin, lactate dehydrogenase).
                          When preventative: avoiding haemolysis, maintenance of post-transfusion Hb at 1 – 3 weeks, no need for repeat transfusion.")
disease = Disease.find(15)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Post-transfusion hyperhaemolysis",
    description: "Post-transfusion hyperhaemolysis (treatment or prevention) – short term use"
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 g/kg a day for two days",
                criteria: "Life- or limb-threatening haemorrhage and failure to respond to other treatments,
                          or prior to invasive procedure, or as directed by patient's haemophilia centre.
                          Excludes acquired VWD associated with IgM gammopathy.",
                outcome: "Rise of factor level. Resolution of bleeding. Number of bleeding episodes.")
disease = Disease.find(16)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Coagulation factor inhibitors",
    description: "Coagulation factor inhibitors (alloantibodies and autoantibodies) in acquired von Willebrand disease (VWD) – short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg in 2-5 divided doses daily; repeated for maximum 2 relapses",
                criteria: "Diagnosis by consultant haematologist from bone marrow biopsy,
                        or pancytopenia with unresponsive to conventional treatment (e.g. corticosteroids, immunosuppressive agents, chemotherapy) or such treatment inappropriate.",
                outcome: "Improvement of cytopenias. Survival. Improvement of HLH markers – ferritin/soluble CD25.")
disease = Disease.find(17)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Haemophagocytic syndrome",
    description: "Haemophagocytic syndrome – short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "1-2 g/kg in 2-5 divided doses daily",
                criteria: "Sudden severe thrombocytopenia 5 to 10 days post-transfusion of blood products with active bleeding.",
                outcome: "Increase in platelet count. Resolution of bleeding. Number of bleeding complications.")
disease = Disease.find(18)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Post-transfusion purpura",
    description: "Post-transfusion purpura – short term use. Very rare in UK following implementation of universal leukocyte reductin of blood components in 1999. Typically occurs in Caucasian HPA-1a antigen negative females previously exposed to HPA-1a antigen in pregnancy or transfusion."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course when relapse, or after 4 weeks if poor response, or after 8 weeks if response and no relapse.",
                criteria: "Probable diagnosis CIDP by neurologist according to the EFNS/International Peripheral Nerve Society Guidelines with significant functional impairment inhibiting normal daily activities.",
                outcome: "Three of MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), Hand dynamometry, Inflammatory RODS score, timed 10m walk,
                          timed up and go 10m walk, Berg Balance scale, Other validated disability score.
                          All patients should have documented assessment pre-treatment, on relapse after first course dosing if relapse occurs, and at best response after end of short term treatment to demonstrate meaningful functional improvement.")
disease = Disease.find(19)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "CIDP (short term)",
    description: "Chronic inflammatory demyelinating polyneuropathy (CIDP) - short term initiation, including IgG or IgA associated paraprotein associated demyelinating neuropathy."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.  Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "Significant functional improvement after short term treatment.",
                outcome: "Clinically meaningful improvement in 3 of: MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), hand dynamometry, inflammatory RODS score, timed 10m walk,
                          timed up and go 10m walk, Berg balance scale, other validated disability score.
                          Annual withdrawal or clinical review scoring to document ongoing need. If > 2-3 failed withdrawals, no need for further withdrawal trials.")
disease = Disease.find(20)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "CIDP (maintenance)",
    description: "Chronic inflammatory demyelinating polyneuropathy (CIDP) - long term use, including IgG or IgA associated paraprotein associated demyelinating neuropathy."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "2 g/kg course divided over 5 days; Second dose may be considered at 14 days for non-responsive or late deteriorating patients if IgG not increased from baseline by > 7g/l.",
                criteria: "Diagnosis of GBS or variant with significant disability (Hughes Grade 4) or disease progression towards intubation and ventilation or
                          mEGRIS score ≥ 3 or poor prognosis with mEGOS ≥ 4. (Miller-Fisher syndrome does not usually require Ig).",
                outcome: "Measure IgG level change as described in regimen.")
disease = Disease.find(21)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Guillain-Barre syndrome",
    description: "Guillain-Barre syndrome (GBS) (includes Bickerstaff’s brainstem encephalitis and other GBS variants)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course when relapse, or after 4 weeks if poor response, or after 8 weeks if response and no relapse.",
                criteria: "Diagnosis by a neurologist, with significant functional impairment inhibiting normal daily activities and other therapies have failed, are contra-indicated or undesirable.",
                outcome: "Clinically meaningful improvement in 3 of: MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), Hand dynamometry, Inflammatory RODS score, timed 10m walk, timed 10m up and go walk, Berg Balance scale.")
disease = Disease.find(22)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "IgM Paraprotein-associated demyelinating neuropathy (short term)",
    description: "IgM Paraprotein-associated demyelinating neuropathy - short term treatment. Note that Ig is seldom significantly effective.
                 Alternative underlying haematological diagnoses should be considered which may direct treatment, or other therapies such as single agent rituximab (or biosimilars) should be considered."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.  Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "Significant functional improvement after short term treatment",
                outcome: "Clinically meaningful improvement in 3 of: MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), Hand dynamometry, Inflammatory RODS score, timed 10m walk, timed 10m up and go walk, Berg Balance scale, other validated disability score.
                          6-monthly withdrawal or clinical review scoring to document ongoing need.")
disease = Disease.find(23)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "IgM Paraprotein-associated demyelinating neuropathy (long term)",
    description: "IgM Paraprotein-associated demyelinating neuropathy - long term treatment. Note that Ig is seldom significantly effective.
                 Alternative underlying haematological diagnoses should be considered which may direct treatment, or other therapies such as single agent rituximab (or biosimilars) should be considered."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course when relapse, or after 4 weeks if poor response, or after 8 weeks if response and no relapse.
                          Maintenance every three months or at relapse interval normally for a maximum of 12 months.",
                criteria: "Diagnosis of myositis by specialist, where diagnosis is PM or DM with significant muscle weakness or
                          where dysphagia unresponsive to corticosteroids and other immunosuppressive agents or
                          where DM with refractory skin involvement.
                          Use steroids first line if progression not rapid. Ig generally used third line after rituximab or biosimilar as adjunctive therapy.",
                outcome: "Clinically meaningful improvement in 3 measures. Dermatomyositis: ADLs, MRC sumscore, quantitative muscle strengths,
                          timed up and go 10m walk, CDASI, FVC, HAQ. Polymyositis: ADLs, MRC sumscore, quantitative muscle strengths,
                          time up and go 10m walk, HAQ, FVC.
                          Record before initiation, on relapse if occurs after first course, after second course, and at yearly intervals thereafter.")
disease = Disease.find(24)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Inflammatory Myopathies",
    description: "Inflammatory Myopathies (usually dermatomyositis (DM) or polymyositis (PM)). Includes immune mediated necrotising myopathy with anti signal recognition particle antibody."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "2 g/kg course, repeated after several days if no response.",
                criteria: "Myasthenic crisis of potentially life threatening nature (ITU with respoiratory or bulbar failure) diagnosed by a neurologist where plasma excahgen not available or failed.",
                outcome: "Quantitative Myasthenia Gravis Score (Duke), respiratory function e.g. forced vital capacity, dysphagia score, dysarthria 1-50 counting, diplopia or ptosis measurement.")
disease = Disease.find(25)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Myasthenia Gravis crisis",
    description: "Myasthenia Gravis (MG) crisis, including Lambert-Eaton Myasthenic Syndrome (LEMs)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 g/kg course, repeated at a frequency to control symptoms.",
                criteria: "Myasthenia diagnosed by a neurologist with weakness requiring hospital admission where plasma exchange not available or failed and rituximab biosimilar failed or unsuitable.
                          Stabilisation prior to surgery or thymectomy.",
                outcome: "Improvement in Quantitative Myasthenia Gravis Score, forward arm abduction time, variation of another myasthenic muuscular score, respiratory function e.g. forced vital capacity, dysphagia score, dysarthria 1-50 counting, diplopia or ptosis measurement.")
disease = Disease.find(26)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Myasthenia Gravis maintenance therapy",
    description: "Myasthenia Gravis (MG) maintenance therapy, including Lambert-Eaton Myasthenic Syndrome (LEMs)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.  Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "Diagnosis by neurologist with or without persistent conduction block and significant functional impairment inhibiting normal daily activities",
                outcome: "Improvement in 3 of: MRC score from 7 pre-defined pairs of muscles, RODS for MMN, Hand dynamometry, ONLS, timed 10m walk, any other validated MMN disability measure.")
disease = Disease.find(27)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Multifocal Motor Neuropathy (short term)",
    description: "MMultifocal Motor Neuropathy (MMN) - short term treatment. Note that treatment regime is the same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.
                          Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "Significant functional improvement after short term treatment.",
                outcome: "Improvement in 3 of: MRC score from 7 pre-defined pairs of muscles, RODS for MMN, Hand dynamometry, ONLS, timed 10m walk, any other validated MMN disability measure.
                          Annual withdrawal or clinical review scoring to document ongoing need. If > 2-3 failed withdrawals, no need for further withdrawal trials.")
disease = Disease.find(28)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Multifocal motor neuropathy (maintenance)",
    description: "Multifocal motor neuropathy - long term use. Note that treatment regime is the same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg divided over 2-5 days every month for three months as initial trial.",
                criteria: "When other therapies such as steroids have failed.",
                outcome: "Continue therapy if seizure reduction of a least 30%.")
disease = Disease.find(29)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Rasmussen’s encephalitis",
    description: "Rasmussen’s encephalitis."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course when relapse, or after 4 weeks if poor response, or after 8 weeks if response and no relapse.",
                criteria: "When other therapies such as steroids have failed.",
                outcome: "Improvement in 2 of: reduction in stiffness, timed up an dgo 10 m walk, BRIT score, number of spasms per day, validated measure of functional abilities.")
disease = Disease.find(30)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Stiff person syndrome (initiation trial)",
    description: "Stiff person syndrome (SPS) or variant - short term use. Regime is same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.
                          Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "When respose to intial short term trial.",
                outcome: "Improvement in 2 of: reduction in stiffness, timed up an dgo 10 m walk, BRIT score, number of spasms per day, validated measure of functional abilities.")
disease = Disease.find(31)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Stiff person syndrome (maintenance)",
    description: "Stiff person syndrome (SPS) or variant - long term use. Regime is same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required (emergency list)",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days.",
                criteria: "When failure to respond to high-dose steroids. This is a left-hand grey indication, which is routinely
                          commissioned requiring prior panel approval, but since life-threating brainstem involvement or encephalopathy can occur, there could be
                          insufficient time for panel approval.",
                outcome: "Clinically meaningful improvement in GCS, seizures or a validated disabillity measure recorded 2-4 weeks after initation of treatment.")
disease = Disease.find(32)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute disseminated encephalomyelitis",
    description: "Acute disseminated encephalomyelitis (ADEM) if high-dose steroids have failed."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required (emergency list)",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days.",
                criteria: "Symptoms requiring intensive care management and failure to respond to high-dose steroids or plasma exchange or when plasma exchange not appropriate.
                          This is a left-hand grey indication, which is routinely
                          commissioned requiring prior panel approval, but since encephalopathy may be acutely life-threatening, there could be
                          insufficient time for panel approval.",
                outcome: "Clinically meaningful improvement in GCS, seizures or a validated disabillity measure recorded 2-4 weeks after initation of treatment.")
disease = Disease.find(33)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune encephalitis",
    description: "Autoimmune encephalitis (including NMDA acute idiopathic dysautonomia and VGKC antibodies, among others)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required (emergency list)",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days for short term stabilisation.",
                criteria: "Acute cerebral infarction in the presence of evidence on blood tests for antiphospholipid syndrome.",
                outcome: "Prevention of further cerebral infarction.")
disease = Disease.find(34)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Cerebral infarction with antiphospholipid antibodies",
    description: "Cerebral infarction with antiphospholipid antibodies."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required (left-hand grey)",
                priority: "3. Grey",
                regimen: "0.5 g/kg dose.",
                criteria: "Chronic complex regional pain syndrome diagnosed by a multidisciplinary team including a Consultant Neurologist or Pain Specialist,
                          and failure to respond to other therapies, such as ketamine, magnesium, and tadalafil.
                          In the absence of clear data on long-term use, such use should be instituted as part of a placebo-controlled trial.",
                outcome: "Reduction in pain by at least 5 points on visual analogue scale, or 2 points versus placebo.")
disease = Disease.find(35)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Complex regional pain syndrome",
    description: "Chronic complex regional pain syndrome (CRPS)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required (emergency list)",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days for short-term stabilisation pending immunosuppressive therapy.",
                criteria: "Infarction or haemorrhage visible on MRI brain, encephalopathy requiring intensive care management,
                          and clear evidence of active vasculitis from laboratory findings, systemic vasculitic involvement or vascular imaging.",
                outcome: "Prevention of further cerebral infarction.")
disease = Disease.find(36)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "CNS vasculitis",
    description: "CNS vasculitis."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required (left-hand grey)",
                priority: "3. Grey",
                regimen: "1 g/kg dose given every 4 weeks for 3 doses (Billiau et al., 2007). Continuatino for another 3 doses if >50% seizure reduction.",
                criteria: "Short to medium control of seizures in children with West syndrome or other intractable epilepsy, when standard antiepileptic drugs, ketotic diet and steroids have failed.",
                outcome: ">50% seizure frequency reduction.")
disease = Disease.find(37)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Intractable childhood epilepsy",
    description: "Intractable childhood epilepsy, especially West syndrome, excluding Rasmussen syndrome which is is a higher level indication.
              Data on response are limited, but the effect is thought to relate to immune mediated brain changes as a result of intractable epilepsy of whatever aetiology.
              The rationale is therefore to break the cycle of intractability with a defined course of treatment. In the retrospective study by
              Tang-Wai et al. (2017) 1 g/kg was used usually every four weeks for several courses. The mean time for best response was
              10 weeks and patients had treatment for 6 months to two years. it seems reasonable therefore to consider a trial for 3 4-weekly doses
              and then to continue a further 12 months if >50% seizure reduction, and to reinstitute for a further 12 months if relapse
              after 24 week withdrawal."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required (left-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg single course divided over 2-5 days. Repeat courses 2-3 monthy if major benefit but relapse, in conjunction with
                          oral immunosuppression.",
                criteria: "Acquired neuromyotonia, with or without Morvan syndrome, debilitating and refractory after treatment with steroids and oral
                          immunosuppression, and after treatment of any underlying malignancy. Plasma exchange should be tried first if available and not contraindicated.",
                outcome: "Major improvement in debilitating and painful muscle cramps, severity of which measured on visual analogue scale before and after treatment.")
disease = Disease.find(38)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Neuromyotonia",
    description: "Acquired neuromyotonia, peripheral or also central (Morvan syndrome), is autoimmune and in 25% associated with underlying malignancy. Only a proportion
                of cases have anti voltage gated potassium channel antibodies. Most non paraneoplastic cases resolve with symptomatic therapy. Debilitating and
                refractory cases are treated with steroids or other immunosuppressants and may respond to plasma exchange. There are case reports of
                response to immunoglobulin."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required (left-hand grey)",
                priority: "3. Grey",
                regimen: "1 g/kg dose every 4 weeks for 12 doses combined with standard chemotherapy and prednisolone
                          oral immunosuppression.",
                criteria: "Acquired neuromyotonia, with or without Morvan syndrome, debilitating and refractory after treatment with steroids and oral
                          immunosuppression, and after treatment of any underlying malignancy. Plasma exchange should be tried first if available and not contraindicated.",
                outcome: "Major improvement in debilitating and painful muscle cramps, severity of which measured on visual analogue scale before and after treatment.")
disease = Disease.find(39)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Opsoclonus myoclonus (paediatric neuroblastoma)",
    description: "This opsoclonus myoclonus refers to the paediatric syndrome associated with neuroblastoma. In conjunction with
    steroids and standard chemotherapy, immunoglobulin in a randomised open label trial was associated with improvement in 81% of
    cases versus 41% of cases not having immunoglobulin (de Alarcon et al., 2017)"
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required (left-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg single course divided over 2-5 days repeated after 8 weeks if partial response.",
                criteria: "Non paranoplastic opsoclonus myoclonus in adults or children, failing to respond to steroids, if plasma exchange failed or not appropriate.",
                outcome: "Major improvement in opsoclonis, myoclonus or associated ataxia as measured on a visual analogue scale of severity before and after treatment.")
disease = Disease.find(40)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Opsoclonus myoclonus (parainfectious)",
    description: "Opsoclonus myoclonus is associated with paediatric neuroblastoma (see separate indication) but
    also in adults with a presumed parainfectious aetiology and with non neuroblastoma paraneoplastic aetiologies. There
    are case reports of good response in parainfectious but not in paraneoplastic cases (Bataller et al., 2001)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Requires IFR (right-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over no fewer than 5 days.",
                criteria: "Acute dysautonomia requiring intensive care management with no clear underlying neuroinflammatory cause. (If any evidence for large fibre involvement should be considered to be Guillain Barre syndrome.)",
                outcome: "Successful discharge from intensive care and symptomatic recovery")
disease = Disease.find(41)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute idiopathic dysautonomia",
    description: "Acute idiopathic dysautonomia is reported in old literature to respond to immunoglobulin. However is is possible that
                variants of Guillain Barre syndrome were being described. If there is any evidence of large fibre neuropathy clinically
                or electrophysiologically, positive antigangioside antibodies or raised protein in cerebrospinal fluid, if requiring intensive care management
                consider recategorising as Guillain Barre syndrome which is routinely commissioned without prior panel approval.")

Disease.create!(speciality: "Neurology",
                commissioning: "Requires IFR (right-hand grey)",
                priority: "3. Grey",
                regimen: "0.5 g/kg as for complex regional pain syndrome.",
                criteria: "Chronic severe facial pain refractory to all appropriate standard therapies and with an aetiology involving a purported immune pathophysiology.",
                outcome: "Reduction in pain by at least 5 points on visual analogue scale, or 2 points versus placebo.")
disease = Disease.find(42)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Chronic facial pain",
    description: "Chronic facial pain is an unsatisfactory diagnosis and probably refers to 'atypical facial pain'. An IFR submission should be accompanied by a more specific diagnosis, e.g. trigeminal neuralgia, tension type headache and facial pain,
              or post-herpetic neuralgia. The data appear to come mainly from Goebel et al. who used immunoglobulin for patients with chronic pain ranging from tension headache to fibromyalgia. The dose was 1 g/kg followed by monthly
              2 g/kg at 4 weekly intervals and continuing if a partial response. In a more recent trial on complex regional pain syndrome the dose used was 0.5 g/kg monthly. That conditino is at least associated with specific
              objective features such as trophic skin changes. An IFR might only be supported if there was some rationale in the literature for an immune mechanism, as purported in refractory epilepsy.")

Disease.create!(speciality: "Neurology",
                commissioning: "Requires IFR (right-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 2-5 days. Repeat after time of relapse if major response.",
                criteria: "Diabetic femoral neuropathy or plexopathy resulting in weakness in the innervated muscles and significant disability.",
                outcome: "Reduction in pain by at least 5 points on visual analogue scale, or 2 points versus placebo.")
disease = Disease.find(43)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Diabetic femoral neuropathy",
    description: "Diabetic femoral neuropathy, or diabetic amyotrophy or diabetic lumbosacral plexopathy, is characterised by pain in the affected area of faily rapid onset, closely followed by weakness.
              In some cases the prognosis is like that of non diabetic lumbosacral neuritis or the more common brachial neuritis. In others, there is little if any improvement after months and the condition
              may become bilateral. There are case reports of a variable, sometimes good response to immunoglobulin, in conjunction with steroids and oral immunosuporession, justified because biopsy reveals a
              microvasculitis. There is also raised protein in cerebrospinal fluid. Suggest therefore a trial of immunoglobulin if no improvement after three months, where immunosuppression or steroids alone have failed.
              Treat as for CIDP if a major response. Note that if there is evidence of demyelination on nerve conduction study, and especially if there was no major pain component initially, if may be appropriate to reclassify the patient as having multifocal
              motor neuropathy or CIDP even if they are diabetic.")


Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "Subgam by intramuscular injection: <10 years 500mg, >10 years 750mg.",
                criteria: "With vaccine in those less able to respond to the vaccine (aged 60 or over or immunosuppressed with CD4 count <200 or those at risk of severe complicaions because of chronic liver disease,
                        including chronic hepatitis B or C).",
                outcome: "Not recorded.")
disease = Disease.find(44)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Hapatitis A",
    description: "Immunoglobulin is given together with vaccine to contacts of high risk patients with acute Hepatitis A infection within 2 weeks of exposure,
                or without vaccine to those exposed 2-4 weeks ago to modify disease course when at risk of severe complications (e.g. chronic liver disease including from hepatitis B or C)."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.15 g/kg of Ig ideally within 72 hours of exposure although can be given up to 6 days later.",
                criteria: "Immunosuppressed individuals (Group A and Group B) who have had significant exposure and known susceptibiity based on vaccine history or IgG levels.
                          Within 6 days of exposure, but consider also between 6 and 18 days.",
                outcome: "Prevention of measles.")
disease = Disease.find(45)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Measles in immunosuppressed",
    description: "Measles (immunosuppressed individuals)"
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "For pregnant contacts: approximately 2250mg = 3 vials of Subgam. For infants: 0.6ml/kg up to a maximum of 1 vial (750mg) Subgam",
                criteria: "Pregnant women identified as susceptible based on vaccine history or antibody testing who have had a significant exposure to measles.
                        Infants under 9 months of age with a significant exposure to measles.
                        Subgam to be given within 6 days of exposure in pregnant women and infants. For infants aged 6-8 months can offer MMR if exposure outside of household and within 72 hours.",
                outcome: "Prevention or resolution of measles.")
disease = Disease.find(46)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Measles in pregnant women and infants",
    description: "Measles in pregnant women and infants."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "<1 year: 250mg. 1 – 2 years: 500mg. >3 years: 750mg. Repeat at 3 weekly intervals if stool samples positive until 2 consecutive negative weekly stool samples.",
                criteria: "To prevent or attenuate an attack in an immunocompromised person inadvertently given live polio vaccine or an immunocompromised person whose contacts are inadvertently given live polio vaccine.",
                outcome: "Prevention or resolution of infection.")
disease = Disease.find(47)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Polio vaccine in immunosuppressed",
    description: "An immunosuppressed individual inadvertantly given live polio vaccine."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "TIG: 250 IU for most uses, 500 IU if >24 hours elapsed or risk of heavy contamination or following burns.
                          Alternatively Subgam 16% one vial of 750mg.
                          Also clean wound thoroughly and give booster of tentatus-containing vaccine.",
                criteria: "Susceptible individuals (incomplete immunisation) sustaining high risk tetanus prone injury (soil or manure exposed wound, burn or animal bite or extensive tissue necrosis).",
                outcome: "Prevention of infection.")
disease = Disease.find(48)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Tetanus prone injury",
    description: "Prophylaxis in tetanus prone injury. Intravenous Ig contains reasonable qualtities of anti-tetanus antibody when tested (specific antibody (TIG) not always available in UK)."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "200ml to 800ml of intravenouos immunoglobulin depending on patient's weight and the immunuglobulin product.",
                criteria: "Acute illness with muscle spasms or hypertonia in the absence of a more likely diagnosis.",
                outcome: "Resolution of infection.")
disease = Disease.find(49)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Clinical Tetanus",
    description: "Suspected case of symptomatic tetanus."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.2 g/kg single dose within 14 days of exposure and ideally within 7 days.",
                criteria: "Intra-muscular injections contra-indicated in individual with significant exposure to chickenpox or shingles and at increased risk (significantly immunosuppressed, neonates and pregnant women)
                          and no antibodies based on VZV antibody testing.",
                outcome: "Prevention of infection.")
disease = Disease.find(50)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Varicella zoster exposure",
    description: "Varicella zoster exposure in immunosuppressed where intramuscular Varicella Ig is contraindicated."
    )





Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "1 g/kg course given to mother starting at 14 weeks gestation given fortnightly, and then weekly from 18 weeks gestation to delivery.",
                criteria: "Usually diagnosis of neonatal hepatic failure haemochromatosis during previous pregnancy and there is 90% risk of occurrence in subsequent pregnancy.",
                outcome: "Fetal survival to term.")
disease = Disease.find(51)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Alloimmunne foetal haemochromatosis",
    description: "Alloimmune foetal and neonatal haemochromatosis disease."
    )


# Book reviews
=begin
user = User.find_by(name: "Mr Admin")
BookReview.create!(user_id: user.id,
            title: "The Best Book",
            author: "John McA",
            description: "This book describes everything and I have to make it at least 100 characters long for it to work
            and then try again to get the full letter count.",
            opinion: "This is the best book in the world and I have to make it at least 100 characters long for it to work
            and then try again to get the full letter count.")
=end


