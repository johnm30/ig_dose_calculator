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
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome.",
                criteria: "Specific primary immunodeficiency diagnosis established by a clinical immunologist. Requires MDT decision if no significant infection burden.",
                outcome: "Trough IgG. Reduction in number of infections, treatment courses of antibiotics, days in hospital.")
disease = Disease.find(1)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Primary immunodeficiency (updated 2022)",
    description: "Primary immunodeficiencies associated with significant antibody defects (excluding specific antibody deficiency which is a separate Red priority commissioned indication) – long term use."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome.",
                criteria: "Profound B cell depletion or significant antibody deficiency.",
                outcome: "Trough IgG. Reduction in number of infections, treatment courses of antibiotics, days in hospital.")
disease = Disease.find(2)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Thymoma immunodeficiency long term use (updated 2022)",
    description: "Thymoma with immunodeficiency – long term use."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome.",
                criteria: "Patients with primary immunodeficiency having haematopoietic stem cell transplantation (HSCT),
                          preferably when recurrent infections. Stop at 2 years and reevalulate in case of B cell reconstitution.",
                outcome: "Trough IgG.")
disease = Disease.find(3)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "HSCT in primary immunodeficiencies – long term use (updated 2022)",
    description: "Patients with primary immunodeficiency having haematopoietic stem cell transplantation (HSCT) – long term use."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month for 6-12 months; dose requirement may increase based on clinical outcome.",
                criteria: "Diagnosed by clinical immunologist. Severe, persistent, opportunistic or recurrent bacterial infections despite continuous oral antibiotic therapy for 6 months,
                          or documented failure of serum antibody response to unconjugated pneumococcal or other polysaccharide vaccine challenge.",
                outcome: "Trough IgG. Reduction in number of infections, treatment courses of antibiotics, days in hospital; record pre-treatment and after 6 months or also 12 months.")
disease = Disease.find(4)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Specific antibody deficiency 6-12 month trial (updated 2022)",
    description: "Specific antibody deficiency - 6-12 month trial."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.4-0.6 g/kg each month; dose requirement may increase based on clinical outcome.",
                criteria: "Diagnosed by clinical immunologist. Severe, persistent, opportunistic or recurrent bacterial infections despite continuous oral antibiotic therapy for 6 months,
                          or documented failure of serum antibody response to unconjugated pneumococcal or other polysaccharide vaccine challenge. Clear evidence of benefit from
                          first 6-12 month trial.",
                outcome: "Trough IgG. Reduction in number of infections, treatment courses of antibiotics, days in hospital; record 6 monthly.")
disease = Disease.find(5)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Specific antibody deficiency beyond 6-12 months (updated 2022)",
    description: "Specific antibody deficiency - long term maintenance after first 6-12 months."
    )

Disease.create!(speciality: "Immunology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "0.4-0.6 g/kg each month; modified to achieve an IgG trough level of at least the lower limit of the age-specific serum IgG reference range.",
                criteria: "Underlying cause of hypogammaglobinaemia cannot be reversed or reversal is contraindicated, or hypogammaglobulinaemia that is drug, HSCT, chronic pulmonary GVHD or malignancy related
                        and associated with recurrent or severe bacterial infection despite continuous oral antibiotic therapy for 6 months or IgG <4 g/L (excluding paraprotein) or
                        (when clinically appropriate eg IgG > 3 g/L) documented failure of serum antibody response to unconjugated pneumococcal or other polysaccharide vaccine challenge.
                        Prophylactic use in B-cell aplasia produced by chimeric antigen recepor T-cell therapy against B-cell antigens. Prophylactic use almost always in CAR-T therapy for B-cell ALL and sometimes for B-cell lymphoma.
                        ",
                outcome: "Trough IgG. Reduction in number of infections and days in hospital; record pre-treatment and 6 monthly thereafter. Review annually and consider seasonal treatment, based on B cell recovery, Ig levels and burden of infection.")
disease = Disease.find(6)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Secondary antibody deficiency long term use (updated 2022)",
    description: "Secondary antibody deficiency - long term use."
    )

################################################################################

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "1 g/kg single dose; second dose if thrombocytopenia persists.",
                criteria: "First line treatment is with HPA-1a/5b negative platelets. Clinical suspicion of NAIT in the neonatal setting based on clinical features suggestive of bleeding e.g. purpura or bruising or more serious bleeding, and a low platelet count.",
                outcome: "Increment in neonatal platelet count.")
disease = Disease.find(7)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Neonatal alloimmune thrombocytopenia (updated 2022)",
    description: "Neonatal alloimmune thrombocytopenia (NAIT)."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "0.5-1 g/kg weekly to start at stage of gestation when risk commences and continue throughout pregnancy.",
                criteria: "In antenatal setting unexplained previous fetal death, haemorrhage, hydrocephalus or thrombocytopenia or known affected sibling, and maternal platelet-specific alloantibodies directed against current paternal antigens (most commonly HPA1a or HPA-5b).",
                outcome: "No haemorrhage after pregnancy, platelets above 50 x 10^9 / l at time of delivery.")
disease = Disease.find(8)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Fetal-maternal Alloimmune Thrombocytopenia (updated 2022)",
    description: "Fetal-maternal Alloimmune Thrombocytopenia (FMAIT)"
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "0.5 g/kg over 4 hours.",
                criteria: "Adjunct to continuous multiple phototherapy in Rhesus or ABO haemolytic disease, when rising bilirubin despite intensive phototherapy.
                          Prevention of foetal haemolytic disease in women with previous history and confirmed red cell antibodies to current paternal or fetal antigens, to delay the need for intrauterine transfusions.",
                outcome: "Bilirubin level. Need for exchange transfusion. Long term morbidity.")
disease = Disease.find(9)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Haemolytic disease of the newborn - short term use (updated 2022)",
    description: "Haemolytic disease of the newborn - short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required (2nd dose on emergency list)",
                priority: "1. Red",
                regimen: "1 g/kg single infusion; 2nd dose after 24–48 hours if severe or life-threatening bleeding or after 5-7 days if haemostatically adequate platelet count not achieved. ",
                criteria: "Life-threatening bleeding, or immediate increase in platelet count is required before emergency surgical procedure or delivery of baby (target count >20 to >100 depending on procedure),
                          or patient haemorrhaging refractory to all other treatment, or moderately severe bleeding if risk of severe bleed (eg mucosal bleeding, multiple sites, previous severe bleed)",
                outcome: "Increase in platelet count, resolution of bleeding, number of bleeding complications.")
disease = Disease.find(10)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute immune thromocytopenia (ITP) short term use (updated 2022)",
    description: "Immune thromocytopenia (ITP) - short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "1 g/kg every 2-3 weeks.",
                criteria: "Patient haemorrhaging refractory to all other treatment during period where other treatments are being tried.",
                outcome: "Increase in platelet count, resolution of bleeding, number of bleeding complications.")
disease = Disease.find(11)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute immune thromocytopenia (ITP) maintenance (updated 2022)",
    description: "Acute immune thromocytopenia (ITP) - maintenance treatment. Note that after requiring 5-6 immunoglobulin courses, and still requiring further treatment,
                  the patient has moved to the chronic phase of ITP."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required",
                priority: "3. Grey",
                regimen: "1 g/kg initialy every 4 weeks, or 2 g/kg if failure to respond to 1 g/kg doses during acute management. Adjust to maximum interdose period while controlling symptoms.",
                criteria: "Antenatally to maintain platelets above 20x10^9/l and 50x10^9/l during delivery.",
                outcome: "Increase in platelet count, resolution of bleeding, number of bleeding complications.")
disease = Disease.find(12)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Chronic immune thromocytopenia (ITP) (updated 2022)",
    description: "Chronic immune thromocytopenia (ITP) is defined as a platelet count <100 x 109/L at 6 months following onset with no other cause found. Immunoglobulin does not appear to reduce the
                potential for acute ITP to progress to the chronic phase but has a role in some chronic cases to minimise bleeding complications in conjunction with steroids (to the limit of tolerability),
                immunosuppressives and thrombopoietin receptor antagonists. Only commissioned antenatally in this situation because immunosuppression inappropriate."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required (emergency list)",
                priority: "2. Blue",
                regimen: "1-1.2 g/kg in divided doses; repeated for maximum 2 relapses",
                criteria: "Parvovirus B19 infection confirmed by PCR, with high viral load usually above 109 IU/ml.
                          Fetal hydrops likely associated with parvovirus B19.",
                outcome: "Rise in haemoglobin. Transfusion independence. Reticulocyte count.")
disease = Disease.find(13)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acquired red cell aplasia from parvovirus B19 (updated 2022)",
    description: "Acquired red cell aplasia associated with chronic parvovirus B19 infection – short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "1-2 g/kg in divided doses.",
                criteria: "Symptomatic or severe anaemia, except in patients with co-morbidities, when steroids failed or contraindicated or prior to splenectory.
                          In pregnancy, for women with warm AHA refractory to corticosteroids or with evidence of fetal anaemia.
                          Neonates of mothers with AHA who have evidence of haemolysis and rising bilirubin despite intensive phototherapy.",
                outcome: "Rise in haemoglobin. Transfusion independence. Reduction in haemolysis markers (bilirubin, lactate dehydrogenase).")
disease = Disease.find(14)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune haemolytic anaemia acute episode (updated 2022)",
    description: "Autoimmune haemolytic anaemia (AHA) including Evans syndrome – acute episode."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required (emergency list)",
                priority: "2. Blue",
                regimen: "1-2 g/kg in divided doses.",
                criteria: "Symptomatic or severe anaemia, except in patients with co-morbidities, when steroids failed or contraindicated or prior to splenectory.
                          In pregnancy, for women with warm AHA refractory to corticosteroids or with evidence of fetal anaemia.
                          Neonates of mothers with AHA who have evidence of haemolysis and rising bilirubin despite intensive phototherapy.
                          Maximum of 2 repeated courses.",
                outcome: "Rise in haemoglobin. Transfusion independence. Reduction in haemolysis markers (bilirubin, lactate dehydrogenase).")
disease = Disease.find(15)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune haemolytic anaemia relapse (updated 2022)",
    description: "Autoimmune haemolytic anaemia (AHA) including Evans syndrome – short term use on relapse."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "2 g/kg divided over 2-5 days with iv methylprednisolone; when preventative, 1-2 g/kg with iv methylprednisolone.",
                criteria: "Symptomatic or severe anaemia (Hb <6g/dL, or sometimes higher, with evidence of on-going intravascular haemolysis due to a delayed haemolytic transfusion/hyperhaemolysis).
                          Prevention of above in patients who had a previous reaction or who have single or multiple allo-antibodies and may require a blood transfusion.",
                outcome: "Rise in haemoglobin. Transfusion Independence. Reduction in haemolysis markers (bilirubin, lactate dehydrogenase).
                          When preventative: avoiding haemolysis, maintenance of post-transfusion Hb at 1 – 3 weeks, no need for repeat transfusion.")
disease = Disease.find(16)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Post-transfusion hyperhaemolysis short term use (updated 2022)",
    description: "Post-transfusion hyperhaemolysis (treatment or prevention) – short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required (emergency list)",
                priority: "2. Blue",
                regimen: "0.4 g/kg for 5 days or 1 g/kg a day for two days, with other treatments such as plasmapheresis, desmopressin, factor VII",
                criteria: "Life- or limb-threatening haemorrhage and failure to respond to other treatments,
                          or prior to invasive procedure, or as directed by patient's haemophilia centre.
                          Excludes acquired VWD associated with IgM gammopathy. This because of a poor sustained response to immunoglobulin
                          compared to that in IgG-associated disease.",
                outcome: "Rise of factor level. Resolution of bleeding. Number of bleeding episodes.")
disease = Disease.find(17)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Coagulation factor inhibitors short term use (updated 2022)",
    description: "Coagulation factor inhibitors (alloantibodies and autoantibodies) in acquired von Willebrand disease (VWD) – short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required (emergency list)",
                priority: "2. Blue",
                regimen: "2 g/kg divided over 2-5 days with steroids; repeated for maximum 2 relapses.",
                criteria: "Diagnosis by consultant haematologist or rheumatologist from H score (pyrexia, organomegaly, multiple cytopenias, triglycerides, fibrinogen, ferritin, AST, bone marrow Bx, immunosuppressants)",
                outcome: "Improvement of cytopenias. Survival. Improvement of HLH markers – ferritin/soluble CD25.")
disease = Disease.find(18)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Haemophagocytic syndrome short term use (updated 2022)",
    description: "Haemophagocytic syndrome (haemophagocytic lymphohistiocytosis (HLH))– short term use."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "1-2 g/kg divided over 2-5 days.",
                criteria: "Sudden severe thrombocytopenia 5 to 10 days post-transfusion of blood products with active bleeding.",
                outcome: "Increase in platelet count. Resolution of bleeding. Number of bleeding complications.")
disease = Disease.find(19)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Post-transfusion purpura short term use (updated 2022)",
    description: "Post-transfusion purpura – short term use. Very rare in UK following implementation of universal leukocyte reduction of blood components in 1999. Typically occurs in Caucasian HPA-1a antigen negative females previously exposed to HPA-1a antigen in pregnancy or transfusion."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval required (emergency list)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 4-5 days single course for stabilisation while preparing other therapies, e.g. rituximab.",
                criteria: "3+ Multiorgan thromboses developing in <7 days with histological evidence of microhaemorrhage in at least one organ and with circulating antibodies, to be given in conjunction with anticoagulation and steroids, and where plasma exchange not immediately available as an appropriate alternative.",
                outcome: "Clinical improvement, reduced antiphospholipid antibody levels")
disease = Disease.find(20)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Catastrophic antiphospholipid syndrome (updated 2022)",
    description: "Catastrophic antiphospholipid syndrome describes multi-organ involvement with circulating lupus anticoagulant or anticardiolipin or antiphospholipid antibodies. Note that significant cerebral
                  infarction alone with these antibodies could be a justification for immunoglobulin and described as a separate indication but is not commissioned."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Requires IFR (former right-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 2-5 days single course repeated if relapse after response.",
                criteria: "Option in cases as outlined in description who are not suitable for immunosuppressive therapy.",
                outcome: "Reduction in requirement for transfusion.")
disease = Disease.find(21)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acquired red cell aplasia NOT due to parvovirus B19",
    description: "Secondary causes of acquired red cell aplasia are generally treated according to the underlying condition. For the remaining
                  primary or refractory cases, with presumed autoimmune aetiology, immunosuppression is instituted with ciclophosphamide, azathioprine, rituximab, ciclosporin or tacrolimus. Immunoglobulin
                  has also been used in such circumstances (Mouthon et al., 2005). In contrast, immunoglobulin is specific and highly effective therapy for parvovirus B19 associated disease and
                  is a separately listed indication."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Requires IFR (former right-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 2-5 days single course.",
                criteria: "There are no longer any clear criteria for the use of immunoglubulin (see description)",
                outcome: "Reduction in life-threatening infections.")
disease = Disease.find(22)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Aplastic anaemia/ pancytopaenia",
    description: "Aplastic anaemia/ pancytopaenia. After excluding secondary causes, such as drug reactions, standard management of aplastic anaemia
                  no longer includes immunoglobulin. Patients are managed with supportive care (blood transfusions and if necessary chelation therapy for iron
                  overload), haemopoietic stem cell transplant or with immunosuppressive therapy (British Committee for Standards in Haematology, 2015). In the last group,
                  first line treatment is specific horse antithymocyte globulin with ciclosporin. Other options include oxymetholone, danazol, eltrombopag or alemtuzumab, not
                  cyclophosphamide. As infection is the major cause of death, prophylactic antibiotics and antifungals are used, not immunoglobulin."
    )


Disease.create!(speciality: "Haematology",
                commissioning: "Requires IFR (former right-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg maximum divided over 2-5 days weekly for 4 weeks.",
                criteria: "Neutrophil count persistently lower than 0.5x10^9/l with severe infection and failure to respond to G-CSF and other immunosuppressives
                          failed or inappropriate. if a patient has previously responded well, the presence of the low neutrophil count and severe infection alone satisfy the criteria.",
                outcome: "Reduction in life-threatening infections, neutrophil count.")
disease = Disease.find(23)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune neutropenia",
    description: "Autoimmune neutropenia is a clinical diagnosis where there is a steadily declining neutrophil count and infectious complications.
                  When secondary to large granular lymphocyte leukaemia, low dose methotrexate or cyclophosphamide may be effective. Treatment of
                  severe symptomatic cases may be with granulocyte colomy stimulating factor. Rituximab has been used. Some authors consider immunoglubulin not
                  to have a role (Farruggia et al., 2015). The Autralian national Blood Authority (2018) recommends immunoglobulin in cases refractory to
                  granulocyte colomy stimulating factor and antibiotics where its role is short term use to help control severe infection."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Requires IFR (former right-hand grey)",
                priority: "3. Grey",
                regimen: "0.4 g/kg daily for 3 days has been used (Zhao et al., 2016).",
                criteria: "No clear recommendations for use.",
                outcome: "Survival. Recoverey of renal function.")
disease = Disease.find(24)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Haemolytic uraemic syndrome",
    description: "Atypical haemolytic uraemic syndrome. Haemolytic uraemic syndrome is typically a complication of E. coli infection in children. Atypical cases
                  have a poorer prognosis and are treated first-line with plasma exchange as well as typical supportive management (UK Clinical Practice Guidelines, 2009). Other treatments include renal transplant,
                  sometimes with rituximab, in patients with certain underlying genetic mutations, or liver/kidney transplant as part of a clinical trial. Recently, eculizumab has been recommended by NICE as an
                  option in treatment of atypical cases (2015). Immunoglobuliln therapy is not listed as an option."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Requires IFR (former right-hand grey)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 2-5 days.",
                criteria: "No clear recommendations for use.",
                outcome: "Survival. Symptom improvement. Reduction in VEGF levels.")
disease = Disease.find(25)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "POEMS",
    description: "POEMS syndrome stands for polyneuropathy, organomegaly, endocrinopathy, M-band on electrophoresis and skin changes. There may also be papilloedema,
                  effusions, oedema and pulmonary hypertension. Treatment includes removal or radiotherapy of isolated plasmacytomas, or immunosuppressives or autologous stem cell
                  transplantation. Bortezomib and bevacizumab have been trialled. Despite the neuropathy of POEMS being demyelinating and often the dominant symptom, immunoglobulin and plasmapheresis are ineffective in POEMS syndrome
                  (Dispenzieri, 2012).")

Disease.create!(speciality: "Haematology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(26)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autologous BMT",
    description: "Autologous bone marrow transplant (BMT)."
    )

################################################################################

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course when relapse, or after 4 weeks if poor response, or after 4-8 weeks regardless.",
                criteria: "Probable diagnosis CIDP by neurologist according to the EFNS/International Peripheral Nerve Society Guidelines with significant functional impairment inhibiting normal daily activities. Consider plasma exchange as alternative or steroids if rapid response not required and not primarily motor.",
                outcome: "Three of MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), hand dynamometry, Inflammatory RODS score, timed 10m walk,
                          timed up and go 10m walk, Berg Balance scale, other validated disability score.
                          All patients should have documented assessment pre-treatment, at best response to demonstrate meaningful functional improvement, and on relapse after first course dosing if relapse occurs.")
disease = Disease.find(27)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "CIDP short term (updated 2022)",
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
disease = Disease.find(28)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "CIDP maintenance (updated 2022)",
    description: "Chronic inflammatory demyelinating polyneuropathy (CIDP) - long term use, including IgG or IgA associated paraprotein associated demyelinating neuropathy."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "2 g/kg course divided over 5 days. Plasma exchange is equally effective. Second Ig dose may be considered at 14 days for non-responsive or late deteriorating patients if IgG not increased from baseline by > 7g/l. New guidance (2022) suggests second dose not effective and may expose to procoagulant harm.",
                criteria: "Diagnosis of GBS or variant with significant disability (Hughes Grade 4) or disease progression towards intubation and ventilation or
                          mEGRIS score ≥ 3 or poor prognosis with mEGOS ≥ 4. (Miller-Fisher syndrome does not usually require Ig).",
                outcome: "Measure IgG level change as described in regimen. New criteria indicates not necessary as would not give second dose anyway.")
disease = Disease.find(29)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Guillain-Barre syndrome (updated 2022)",
    description: "Guillain-Barre syndrome (GBS) (includes Bickerstaff’s brainstem encephalitis and other GBS variants)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course after 4-8 weeks.",
                criteria: "Diagnosis by a neurologist, with significant functional impairment inhibiting normal daily activities and other therapies have failed, are contra-indicated or undesirable.",
                outcome: "Clinically meaningful improvement in 3 of: MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), hand dynamometry, Inflammatory RODS score, timed 10m walk, timed 10m up and go walk, Berg Balance scale, other validated disability score.")
disease = Disease.find(30)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "IgM Paraprotein-associated demyelinating neuropathy short term (updated 2022)",
    description: "IgM Paraprotein-associated demyelinating neuropathy - short term treatment. Note that Ig is seldom significantly effective.
                 Alternative underlying haematological diagnoses should be considered which may direct treatment. Not for long term use if ineffective or relapse; instead rituximab (or biosimilar) is commissioned."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former left-hand Grey indication)",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.  Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "Significant functional improvement after short term treatment",
                outcome: "Clinically meaningful improvement in 3 of: MRC score (7 pairs of muscles in upper and lower limb scored 0–5, maximum 70), INCAT sensory sum score,
                          ONLS (Overall Neuropathy Limitation Score), hand dynamometry, Inflammatory RODS score, timed 10m walk, timed 10m up and go walk, Berg Balance scale, other validated disability score.
                          6-monthly withdrawal or clinical review scoring to document ongoing need.")
disease = Disease.find(31)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "IgM paraprotein-associated demyelinating neuropathy long term (updated 2022)",
    description: "IgM paraprotein-associated demyelinating neuropathy - long term treatment. Rituximab is commissioned instead."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course after 4-8 weeks.
                          Maintenance every three months or at relapse interval normally for a maximum of 12 months.",
                criteria: "Diagnosis of myositis by specialist, where diagnosis is PM or DM with significant muscle weakness or
                          where dysphagia or respiratory failure unresponsive to corticosteroids and other immunosuppressive agents or
                          where DM with refractory skin involvement.
                          Use steroids first line if progression not rapid. 2nd line rituximab or biosimilar as adjunctive therapy. 3rd line abatacept (fusion of cytotoxic T-lymphocyte-associated antigen 4 (CTLA-4) with Fc of IgG1). Ig is therefore considered 4th line treatment, best considered an adjunct while awaiting response to immunosuppressives.",
                outcome: "Clinically meaningful improvement in 3 measures. Dermatomyositis: ADLs, MRC sumscore, quantitative muscle strengths,
                          timed up and go 10m walk, CDASI, FVC, HAQ. Polymyositis: ADLs, MRC sumscore, quantitative muscle strengths,
                          time up and go 10m walk, HAQ, FVC. Juvenile dermatomyositis: MMT-8, CMAS score, CK levels, PGALS for inflamed joints.
                          Record before initiation, on relapse if occurs after first course, after second course, and at yearly intervals thereafter.")
disease = Disease.find(32)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Inflammatory Myopathies (updated 2022)",
    description: "Inflammatory Myopathies (usually dermatomyositis (DM) or polymyositis (PM)). Includes immune mediated necrotising myopathy with anti signal recognition particle antibody."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required (but not if crisis)",
                priority: "1. Red if no plasma exchange available",
                regimen: "1 g/kg course, repeated if deterioration or no response. 2g/kg if respiratory or bulbar crisis.",
                criteria: "Myasthenia diagnosed by a neurologist in acute exacerbation or weakness requiring hospital admission or prior to surgery, including thymectomy.",
                outcome: "Quantitative Myasthenia Gravis Score (Duke), respiratory function e.g. forced vital capacity, dysphagia score, dysarthria 1-50 counting, diplopia or ptosis measurement.")
disease = Disease.find(33)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Myasthenia Gravis acute exacerbation (updated 2022)",
    description: "Myasthenia Gravis (MG) acute management, including Lambert-Eaton Myasthenic Syndrome (LEMs)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 g/kg course, repeated at a frequency to control symptoms.",
                criteria: "Myasthenia diagnosed by a neurologist in rare circumstances when steroids and immunosuppression, including commissioned rituximab or biosimilar, failed.",
                outcome: "Improvement in Quantitative Myasthenia Gravis Score, forward arm abduction time, variation of another myasthenic muuscular score, respiratory function e.g. forced vital capacity, dysphagia score, dysarthria 1-50 counting, diplopia or ptosis measurement.")
disease = Disease.find(34)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Myasthenia Gravis maintenance therapy (updated 2022)",
    description: "Myasthenia Gravis (MG) maintenance therapy, including Lambert-Eaton Myasthenic Syndrome (LEMs)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "2. Red",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course after 4-8 weeks.",
                criteria: "Diagnosis by neurologist with or without persistent conduction block and significant functional impairment inhibiting normal daily activities.",
                outcome: "Improvement in 3 of: MRC score from 7 pre-defined pairs of muscles, RODS for MMN, Hand dynamometry, ONLS, timed 10m walk, any other validated MMN disability measure.")
disease = Disease.find(35)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Multifocal Motor Neuropathy short term (updated 2022)",
    description: "Multifocal Motor Neuropathy (MMN) - short term treatment. Note that the treatment regime is the same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.
                          Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "Significant functional improvement after short term treatment.",
                outcome: "Improvement in 3 of: MRC score from 7 pre-defined pairs of muscles, RODS for MMN, Hand dynamometry, ONLS, timed 10m walk, any other validated MMN disability measure.
                          Annual withdrawal or clinical review scoring to document ongoing need. If > 2-3 failed withdrawals, no need for further withdrawal trials.")
disease = Disease.find(36)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Multifocal motor neuropathy maintenance (updated 2022)",
    description: "Multifocal motor neuropathy - long term use. Note that the treatment regime is the same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg divided over 2-5 days every month for three months as initial trial.",
                criteria: "When other therapies such as steroids have failed.",
                outcome: "Continue therapy if seizure reduction of a least 30%.")
disease = Disease.find(37)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Rasmussen’s encephalitis (updated 2022)",
    description: "Rasmussen’s encephalitis."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days. 2nd course after 4-8 weeks.",
                criteria: "Diagnosed by consultant neurologist with antoantibodies to GAD, DPPX, amphyphysin, gephyrin or with continuous motor unit activity at rest in paraspinal or limb muscle. Plasma exchange is alternative, as is rituximab but not commissioned.",
                outcome: "Improvement in 2 of: reduction in stiffness, timed up and go 10 m walk, BRIT score, number of spasms per day, validated measure of functional abilities.")
disease = Disease.find(38)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Stiff person syndrome initiation trial (updated 2022)",
    description: "Stiff person syndrome (SPS) or variant - short term use. Regime is same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days repeated at intervals of three months or at relapse interval if relapsed during short term treatment.
                          Attempt dose reductions of 20% each course until demonstrated inferior response.",
                criteria: "When response to initial short term trial.",
                outcome: "Improvement in 2 of: reduction in stiffness, timed up and go 10 m walk, BRIT score, number of spasms per day, validated measure of functional abilities.")
disease = Disease.find(39)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Stiff person syndrome maintenance (updated 2022)",
    description: "Stiff person syndrome (SPS) or variant - long term use. Regime is same as for CIDP."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 2-5 days.",
                criteria: "Acute significant attack when failure to respond to high-dose steroids plasma exchange not available and evidence of active ongoing inflammation.",
                outcome: "Clinically meaningful improvement in GCS, seizures or a validated disability measure recorded 2-4 weeks after initiation of treatment.")
disease = Disease.find(40)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute disseminated encephalomyelitis (ADEM), Devics (neuromyelitis optica spectrum) and transverse myelitis short term treatment (updated 2022)",
    description: "Non-MS CNS inflammatory disease covering the clinical phenotype of aquaporin 4 (AQP4) antibody disease (Devics) , neuromyelitis optica spectrum disorder (NMOSD), acute disseminated encephalomyelitis (ADEM) (with or without encephalopathy, including brainstem attacks), myelin ologodendrocyte associated glycoprotein (MOG) disease, transverse myelitis, optic neuritis. Specifically excludes MS, Behcets, sarcoid."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course divided over 5 days, repeated at 3-6 week intervals up to 3 times. if repeat doses required consider alternative longer term strategy immediately",
                criteria: "Non infective encephalitis clinically strongly suspected (evidence of inflammatory CNS disorder with active csf, seizures, consistent MR imaging changes) or antibody confirmed with functional disability and failure to respond to high-dose steroids or plasma exchange or when plasma exchange not appropriate.
                          Exclusions are infective encephalitis or non inflammatory causes of encephalopathy or seizures.
                          This requires prior approval but since encephalopathy may be acutely life-threatening, there could be
                          insufficient time. Consider recruitment in Enceph-Ig trial. Note that paraneoplastic neurological disorder is a separate category that need not be encepahlitic but requires identification of relevant tumour.",
                outcome: "Clinically meaningful improvement in GCS, seizures, MRI appearance, hyponatraemia if relevant, antibody titre or a validated disability measure (eg modified Rankin score, validated cognitive test) recorded 2-4 weeks after initiation of treatment.")
disease = Disease.find(41)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune encephalitis (updated 2022)",
    description: "Autoimmune encephalitis/ encephalitides (including with NMDA receptor, VGKC, LGI1, Caspr2 (voltage gated potassium channel), GAD, DPPX, AMPA, GABAb antibodies among others)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR but multi-organ catastrophic thrombosis commissioned",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days for short term stabilisation.",
                criteria: "Acute cerebral infarction in the presence of evidence on blood tests for antiphospholipid syndrome.",
                outcome: "Prevention of further cerebral infarction.")
disease = Disease.find(42)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Cerebral infarction with antiphospholipid antibodies",
    description: "Cerebral infarction with antiphospholipid antibodies. There is concern that if clear acute stroke and known previous antiphospholipid associated disease, Ig could reduce permanent disability."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former left-hand Grey indication)",
                priority: "3. Grey",
                regimen: "0.5 g/kg dose.",
                criteria: "Chronic complex regional pain syndrome diagnosed by a multidisciplinary team including a Consultant Neurologist or Pain Specialist,
                          and failure to respond to other therapies, such as ketamine, magnesium, and tadalafil.
                          In the absence of clear data on long-term use, such use should be instituted as part of a placebo-controlled trial.",
                outcome: "Reduction in pain by at least 5 points on visual analogue scale, or 2 points versus placebo.")
disease = Disease.find(43)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Complex regional pain syndrome (updated 2022)",
    description: "Chronic complex regional pain syndrome (CRPS). This was formally commissioned as a left-hand grey indication."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former unlisted)",
                priority: "3. Grey",
                regimen: "2 g/kg course divided over 2-5 days for short-term stabilisation pending immunosuppressive therapy.",
                criteria: "Infarction or haemorrhage visible on MRI brain, encephalopathy requiring intensive care management,
                          and clear evidence of active vasculitis from laboratory findings, systemic vasculitic involvement or vascular imaging.",
                outcome: "Prevention of further cerebral infarction.")
disease = Disease.find(44)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "CNS vasculitis (updated 2022)",
    description: "CNS vasculitis. See under ANCA associated systemic vasculitis."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former left-hand Grey indication)",
                priority: "3. Grey",
                regimen: "1 g/kg dose given every 4 weeks for 3 doses (Billiau et al., 2007). Continuation for another 3 doses if >50% seizure reduction.",
                criteria: "Short to medium control of seizures in children with West syndrome or other intractable epilepsy, when standard antiepileptic drugs, ketotic diet and steroids have failed.",
                outcome: ">50% seizure frequency reduction.")
disease = Disease.find(45)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Intractable childhood epilepsy (updated 2022)",
    description: "Intractable childhood epilepsy, especially West syndrome, excluding Rasmussen syndrome which is a higher level indication.
              Data on response are limited, but the effect is thought to relate to immune mediated brain changes as a result of intractable epilepsy of whatever aetiology.
              The rationale is therefore to break the cycle of intractability with a defined course of treatment. In the retrospective study by
              Tang-Wai et al. (2017) 1 g/kg was used usually every four weeks for several courses. The mean time for best response was
              10 weeks and patients had treatment for 6 months to two years. It seems reasonable therefore to consider a trial for 3 4-weekly doses
              and then to continue a further 12 months if >50% seizure reduction, and to reinstitute for a further 12 months if relapse
              after 24 week withdrawal. Formally listed as a left-hand grey indication."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg single course divided over 2-5 days, repeated at 6 weeks then titrated; combine with other treatments.",
                criteria: "Autoimmune neuromyotonia, with or without Morvan syndrome, debilitating and supported with electrophysiological studies with or without voltage gated K channel (Caspr) antibodies. Refractory after treatment with symptomatic anticonvulsants, steroids and oral
                          immunosuppression, plasma exchange. Treat any underlying malignancy.",
                outcome: "Timed up and go walk, myotonia behaviour scale, Rivermed mobility index, brief pain inventory, neurophysiological assessment, major improvement in debilitating and painful muscle cramps, severity of which measured on visual analogue scale before and after treatment.")
disease = Disease.find(46)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Neuromyotonia (updated 2022)",
    description: "Acquired neuromyotonia, peripheral (Isaac's syndrome) or also central (Morvan syndrome), is autoimmune and in 25% associated with underlying malignancy. Only a proportion
                of cases have anti voltage gated potassium channel antibodies. Most non paraneoplastic cases resolve with symptomatic therapy. Debilitating and
                refractory cases are treated with steroids or other immunosuppressants and may respond to plasma exchange. There are case reports of
                response to immunoglobulin."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 g/kg dose every 4 weeks for 12 doses combined with standard chemotherapy and prednisolone
                          oral immunosuppression.",
                criteria: "Child with neuroblastoma, in conjunction with steroids and standard chemotherapy.",
                outcome: "OMS score, major improvement in opsoclonus, myoclonus or associated ataxia as measured on a visual analogue scale of severity before and after treatment.")
disease = Disease.find(47)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Opsoclonus myoclonus (paediatric neuroblastoma) (updated 2022)",
    description: "This opsoclonus myoclonus refers to the paediatric syndrome associated with neuroblastoma. In conjunction with
    steroids and standard chemotherapy, immunoglobulin in a randomised open label trial was associated with improvement in 81% of
    cases versus 41% of cases not having immunoglobulin (de Alarcon et al., 2017)"
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg single course divided over 2-5 days repeated after 8 weeks if partial response.",
                criteria: "Non paraneoplastic opsoclonus myoclonus in adults or children, with no structural or inflammatory focal lesion, failing to respond to steroids, if plasma exchange failed or not appropriate.",
                outcome: "OMS score, major improvement in opsoclonis, myoclonus or associated ataxia as measured on a visual analogue scale of severity before and after treatment.")
disease = Disease.find(48)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Opsoclonus myoclonus (parainfectious) (updated 2022)",
    description: "Opsoclonus myoclonus is associated with paediatric neuroblastoma (see separate indication) but
    also in children or adults with a presumed parainfectious aetiology and with non neuroblastoma paraneoplastic aetiologies. There
    are case reports of good response in parainfectious but not in paraneoplastic cases (Bataller et al., 2001)."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg divided over no fewer than 5 days, innitially repeated at 6 weeks then titrated to optimal interval and minumum dose",
                criteria: "Acute dysautonomia requiring intensive care management or authorised by specialist autonomic unit with ganglionic alpha 3 ACh receptor antibodies or acute clinical picture with pupil involvement. (If any evidence for large fibre involvement should be considered to be Guillain Barre syndrome.)",
                outcome: "Postural drop reduction, inproved ADL, time to significant postural bp fall, syncopal episodes, oral dryness, diarrhoea or constipation frequency.")
disease = Disease.find(49)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute idiopathic dysautonomia (updated 2022)",
    description: "Acute idiopathic dysautonomia or gangionopathy is reported in old literature to respond to immunoglobulin. However is is possible that
                variants of Guillain Barre syndrome were being described. It is now categorised as commissioned (2022). If there is any evidence of large fibre neuropathy clinically
                or electrophysiologically, positive antigangioside antibodies or raised protein in cerebrospinal fluid, if requiring intensive care management
                consider recategorising as Guillain Barre syndrome which is routinely commissioned without prior panel approval.")

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former right-hand Grey indication)",
                priority: "3. Grey",
                regimen: "0.5 g/kg as for complex regional pain syndrome.",
                criteria: "Chronic severe facial pain refractory to all appropriate standard therapies and with an aetiology involving a purported immune pathophysiology.",
                outcome: "Reduction in pain by at least 5 points on visual analogue scale, or 2 points versus placebo.")
disease = Disease.find(50)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Chronic facial pain (updated 2022)",
    description: "Chronic facial pain is an unsatisfactory diagnosis and probably refers to 'atypical facial pain'. An IFR submission should be accompanied by a more specific diagnosis, e.g. trigeminal neuralgia, tension type headache and facial pain,
              or post-herpetic neuralgia. The data appear to come mainly from Goebel et al. who used immunoglobulin for patients with chronic pain ranging from tension headache to fibromyalgia. The dose was 1 g/kg followed by
              2 g/kg at 4 weekly intervals and continuing if a partial response. In a more recent trial on complex regional pain syndrome the dose used was 0.5 g/kg monthly. That condition is at least associated with specific
              objective features such as trophic skin changes. An IFR might only be supported if there was some rationale in the literature for an immune mechanism, as purported in refractory epilepsy. Formerly listed as a right-hand grey indication.")

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former right-hand Grey indication)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 2-5 days. Repeat after time of relapse if major response.",
                criteria: "Diabetic femoral neuropathy or plexopathy resulting in weakness in the innervated muscles and significant disability.",
                outcome: "As for CIDP.")
disease = Disease.find(51)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Diabetic proximal neuropathy (updated 2022)",
    description: "Diabetic proximal neuropathy, or diabetic femoral neuropathy or diabetic amyotrophy or diabetic lumbosacral plexopathy, is characterised by pain in the affected area of fairly rapid onset, closely followed by weakness.
              In some cases the prognosis is like that of non diabetic lumbosacral neuritis or the more common brachial neuritis. In others, there is little if any improvement after months and the condition
              may become bilateral. There are case reports of a variable, sometimes good, response to immunoglobulin, in conjunction with steroids and oral immunosuppression, justified because biopsy reveals a
              microvasculitis. There is also raised protein in cerebrospinal fluid. Suggest therefore a trial of immunoglobulin if no improvement after three months, where immunosuppression or steroids alone have failed.
              Treat as for CIDP if a major response. Note that if there is evidence of demyelination on nerve conduction study, and especially if there was no major pain component initially, if may be appropriate to reclassify the patient as having multifocal
              motor neuropathy or CIDP even if they are diabetic. Formerly listed as a grey indication.")

Disease.create!(speciality: "Neurology",
                commissioning: "Not commissioned and requires IFR (former right-hand Grey indication)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 2-5 days single course.",
                criteria: "Authorities typically recommend treatment only as part of a double-blinded placebo controlled trial. Plasma exchange is an alterative.",
                outcome: "Reduction in OCD, anxiety, or tic severity scale scores.")
disease = Disease.find(52)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "PANDAS (updated 2022)",
    description: "Paediatric autoimmune neuropsychiatric disorders associated with streptococcal infection (PANDAS) is a <i>hypothesised</i> autoimmune encephalopathy
                  following group A streptococcal infection and resulting especially in obsessive compulsive disorder and tics. Controversial treatments include
                  prophylactic antibiotics to prevent exacerbations from further infections, and plasma exchange or immunoglobulin. An initial study showed sustained
                  improvement following a single course of immunoglobulin for a current exacerbation of previous tics or OCD temporally related to streptococcal infection (Perlmutter et al., 1999).
                  However these results have not reliably been replicated. Formerly listed as a right-hand grey indication.")

Disease.create!(speciality: "Neurology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(53)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Adrenoleukodystrophy",
    description: "Adrenoleukodystrophy."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(54)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Alzheimer's disease",
    description: "Alzheimer's disease."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "If multifocal motor neuropathy is a differential diagnosis see under that indication.",
                outcome: "Not recommended.")
disease = Disease.find(55)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Amyotrophic lateral sclerosis",
    description: "Amyotrophic lateral sclerosis (motoneurone disease). Note that aysymmetrical exclusively lower motoneurone involvement may be
                  hard to distinguish from multifocal motor neuropathy even if no conduction block, and a trial of immunoglobulin efficacy might
                  be appropriate in that circumstance."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(56)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Chronic fatigue syndrome",
    description: "Chronic fatigue syndrome."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(57)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Critical illness neuropathy",
    description: "Critical illness neuropathy."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(58)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Multiple sclerosis",
    description: "Multiple sclerosis."
    )

################################################################################

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval via UKHSA health protection team (https://www.gov.uk/healthprotectionteam)",
                priority: "1. Red",
                regimen: "Subgam by intramuscular injection: <10 years 500mg, >10 years 1000mg.",
                criteria: "Given with vaccine when within 2 weeks of exposure (or otherwise when within 2-4 weeks of exposure) in those less able to respond to the vaccine (aged 60 or over OR immunosuppressed with CD4 count <200 OR those at risk of severe complications because of chronic liver disease,
                        including chronic hepatitis B or C).",
                outcome: "Does not contract hepatitis A.")
disease = Disease.find(59)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Hepatitis A (updated 2022)",
    description: "Immunoglobulin is given together with vaccine to high risk contacts of patients with acute Hepatitis A infection within 2 weeks of exposure,
                or without vaccine to those exposed 2-4 weeks ago to modify disease course when at risk of severe complications (e.g. chronic liver disease including from hepatitis B or C)."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval via UKHSA health protection team (https://www.gov.uk/healthprotectionteam)",
                priority: "1. Red",
                regimen: "0.15 g/kg of Ig ideally within 72 hours of exposure although can be given up to 6 days later.",
                criteria: "Immunosuppressed individuals (Group A and Group B) who have had significant exposure and known susceptibility based on vaccine history or IgG levels.
                          Within 6 days of exposure, but consider also between 6 and 18 days.",
                outcome: "Prevention of measles.")
disease = Disease.find(60)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Measles in immunosuppressed (updated 2022)",
    description: "Measles (immunosuppressed individuals)."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval via UKHSA health protection team (https://www.gov.uk/healthprotectionteam)",
                priority: "1. Red",
                regimen: "For pregnant contacts: approximately 3000mg of human normal immunoglobulin (HNIG) (in vials of Subgam). For infants: 0.6ml/kg up to a maximum of 1000mg Subgam",
                criteria: "Pregnant women identified as susceptible based on vaccine history or antibody testing who have had a significant exposure to measles.
                        Infants under 9 months of age with a significant exposure to measles.
                        Subgam to be given within 6 days of exposure in pregnant women and infants. For infants aged 6-8 months can offer MMR if exposure outside of household and within 72 hours.",
                outcome: "Prevention or resolution of measles.")
disease = Disease.find(61)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Measles in pregnant women and infants (updated 2022)",
    description: "Measles in pregnant women and infants."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval via UKHSA health protection team (https://www.gov.uk/healthprotectionteam)",
                priority: "1. Red",
                regimen: "<1 year: 250mg. 1 – 2 years: 500mg. >3 years: 750mg. Repeat at 3 weekly intervals if stool samples positive until 2 negative weekly stool samples.",
                criteria: "To prevent or attenuate an attack in an immunocompromised person inadvertently given live polio vaccine or an immunocompromised person whose contacts are inadvertently given live polio vaccine.",
                outcome: "Prevention or resolution of infection.")
disease = Disease.find(62)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Polio vaccine in immunosuppressed (updated 2022)",
    description: "An immunosuppressed individual inadvertently given live polio vaccine or exposed to contacts given live vaccine."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "TIG: 250 IU for most uses, 500 IU if >24 hours elapsed or risk of heavy contamination or following burns.
                          Alternatively Subgam 16% one vial of 750mg.
                          Also clean wound thoroughly and give booster of tentatus-containing vaccine.",
                criteria: "Susceptible individuals (incomplete immunisation) sustaining high risk tetanus prone injury (soil or manure exposed wound, burn or animal bite or extensive tissue necrosis) within incubation period for tetanus of 10-21 days.",
                outcome: "Prevention of infection.")
disease = Disease.find(63)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Tetanus prone injury (updated 2022)",
    description: "Prophylaxis in tetanus prone injury. Intravenous Ig contains reasonable quantities of anti-tetanus antibody when tested (specific antibody tetanus specific immunoglobulin (TIG) not always available in UK)."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "200ml to 800ml of intravenous immunoglobulin depending on patient's mass and the immunuglobulin product. (Dosage based on equivalent dose of anti-tetanus
                          antibodies of 5000 IU for individuals < 50kg and 10000 for individuals > 50kg.",
                criteria: "Acute illness with muscle spasms or hypertonia in the absence of a more likely diagnosis.",
                outcome: "Resolution of condition.")
disease = Disease.find(64)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Clinical tetanus (updated 2022)",
    description: "Suspected case of symptomatic tetanus."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval via UKHSA health protection team (https://www.gov.uk/healthprotectionteam)",
                priority: "1. Red",
                regimen: "0.2 g/kg single dose within 14 days of exposure and ideally within 7 days. No further dose if second exposure within 3 weeks of first dose.",
                criteria: "Intra-muscular injections of VZIG contra-indicated in individual with significant exposure to chickenpox or shingles and at increased risk (significantly immunosuppressed (Group A or Group B), neonates and pregnant women)
                          and no antibodies based on VZV antibody testing.",
                outcome: "Prevention of infection.")
disease = Disease.find(65)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Varicella zoster exposure (updated 2022)",
    description: "Varicella zoster exposure in immunosuppressed where intramuscular Varicella Ig is contraindicated."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval not required (urgency acknowledged by policy)",
                priority: "2. Blue",
                regimen: "1 g/kg as a single dose, consider further 1 g/kg dose if no improvement at 24 hours",
                criteria: "Diagnosis of life threatening streptococcal or staphylococcal toxic shock syndrome (TSS), preferably with isolation of organism, and failure to achieve rapid improvement
                          with antibiotic therapy and other supportive measures.",
                outcome: "Improvement of FBC, ALK, CPK; reduction in hospital inpatient stay; survival.")
disease = Disease.find(66)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Staphylococcal or streptococcal toxic shock syndrome - short term use (updated 2022)",
    description: "Necrotising (including Panton-Valentine leukocidin (PVL)-associated) staphylococcal or streptococcal sepsis or toxic shock syndrome. The benefit of Ig in streptococcal sepsis TSS is more controversial."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval required (formerly on emergency list)",
                priority: "2. Blue",
                regimen: "0.4 g/kg single dose, consider repeating once.",
                criteria: "Severe cases (WCC >15, acute rising creatinine or signs/symptoms of colitis) not responding to oral
                          vancomycin 125 mg qds with or without iv netromidazole or oral rifampicin. Consider immunoglobulin
                          especially if multiple relapses or evidence of malnutrition. Tigecycline iv and fecal microbiotica transplantation (approved by NICE) are alternatives to Ig.",
                outcome: "Any measure of significant clearance of C. difficile; duration of hospital inpatient stay.")
disease = Disease.find(67)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Severe or recurrent C. difficile colitis (updated 2022)",
    description: "Severe or recurrent Clostridium difficile colitis."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Not commissioned and requires IFR (former Grey indication)",
                priority: "3. Grey",
                regimen: "0.2 g/kg single dose within 14 days of exposure and ideally within 7 days.",
                criteria: "Intra-muscular injections contra-indicated in individual with significant exposure to infection and at increased risk (significantly immunosuppressed, neonates and pregnant women)",
                outcome: "Prevention of infection.")
disease = Disease.find(68)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Post-exposure prophylaxis (excluding varicella, measles, Hepatitis A, tetanus) (updated 2022)",
    description: "Post-exposure prophylaxis for certain viral or other infections if intramuscular injection contraindicated or when hyperimmune immunoglobulins are unavailable. This was a former grey indication.
                  This excludes varicella and certain other exposures, which are commissioned indications for immunogobulin."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(69)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Immunodeficiency secondary to paediatric HIV infection",
    description: "Immunodeficiency secondary to paediatric HIV infection."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(70)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Neonatal sepsis",
    description: "Neonatal sepsis (prevention or treatment)."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(71)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Sepsis in the intensive care unit",
    description: "Sepsis in the intensive care unit not related to specific toxins or C. difficile."
    )


Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "2 g/kg single dose given over 10-12 hours, in conjunction with high dose aspirin. Second dose if no response or relapse within 48h.",
                criteria: "Clinical diagnosis by a paediatrician or immunologist or in adult cases of PIMS-TS by a consultant in infection or immunologist or appropriate MDT",
                outcome: "Resolution of fever, improvement in acute phase markers.")
disease = Disease.find(72)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Kawasaki disease including COVID-19 Kawasaki like syndrome (updated 2022)",
    description: "Kawasaki disease. Includes Paediatric Inflammatory Multisystem Syndrome temporarily associated with coronavirus COVID-19 (PIMS-TS) (https://www.rcpch.ac.uk/)."
    )

Disease.create!(speciality: "Other",
                commissioning: "Not commissioned (former Red indication)",
                priority: "1. Red",
                regimen: "2 g/kg single dose or divided over 3 days.",
                criteria: "Diagnosis by a dermatologist and life threatening or when involved body surface area >10% and other treatments contraindicated, if started within first 48-72 hours. This was removed from commissioning in 2021.
                Reviews by Kohanim et al (2016) and Momin (2009) indicate it may be of benefit but evidence is hampered by lack of clinical trials, which is understandable given it is a rare and emergency and potentially rapidly fatal condition. In
                the absence of sight of a trial showing no benefit, an SRIAP might immediately recommend use and retrospective IFR request.",
                outcome: "Resolution of the disease.")
disease = Disease.find(73)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Toxic epidermal necrolysis (updated 2022)",
    description: "Toxic epidermal necrolysis (Stevens Johnson syndrome)."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval required",
                priority: "1. Red",
                regimen: "1 g/kg course (max 60 g and calculated from mother's booking weight) given fortnightly to mother starting at 14 weeks gestation, and then weekly from 18 weeks gestation to delivery.",
                criteria: "Pregnant mothers with a previous miscarriage and fetal post-mortem evidence of haemochromatosis, or women with previous live birth of
                neonate with confirmed alloimmune haemochromatosis. Decision to treat by consultant obstetrician with input from liver unit specialist.",
                outcome: "Fetal survival to term.")
disease = Disease.find(74)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Alloimmunne fetal or neonatal haemochromatosis (updated 2022)",
    description: "Alloimmune neonatal haemochromatosis, or gestational alloimmune liver disease (GALD) usually in the context of a
    diagnosis of neonatal hepatic failure haemochromatosis during a previous pregnancy and knowledge that there is 90% risk of occurrence in subsequent pregnancy."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "Up to 2 g/kg course given to recipient, repeated according to donor specific antibody levels; for renal desensitisation give 0.1 g/kg for 8-12 doses.",
                criteria: "Patients in whom renal, heart or lung transplant is prevented because of antibodies.",
                outcome: "Renal: type of transplant, HLA class DSA, rejection episodes, patient/graft survival, eGFR. Cardiothoracic: DSA, length of ITU and hospital stay. Graft function (heart = ejection fraction, lung = spirometry, liver = liver function and clotting indices).")
disease = Disease.find(75)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Transplantation (solid organ) antibody incompatible transplant - short term use (updated 2022)",
    description: "Transplantation (solid organ) antibody incompatible transplant (AIT). Previously, prior approval was required."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval not required",
                priority: "2. Blue",
                regimen: "Up to 2 g/kg course, repeated for 2-3 courses. Note that Barts Health Renal Transplant team has a specific regime of regular plasma exchange
                          combined with Ig 0.1g/kg on days 3, 5 and 7 of treatment regime, and 2g/kg on day 9. A low volume Ig brand is preferable. Note that plasma exchange shortly after Ig may negate the Ig and is not supported by the Commissioning policy (2021)",
                criteria: "Patients experiencing steroid resistant rejection or where other therapies are contraindicated after transplant. In renal transplant rejection, antibody-mediated
                as opposed to cellular rejection is determined by the presence of donor specific HLA antibodies (DSA) and the histological appearance
                on biopsy. DSA monitoring is repeated on day 3 and on day 9 of the treatment regime.",
                outcome: "Renal: type of transplant, HLA class DSA, rejection episodes, patient/graft survival, eGFR. Cardiothoracic: DSA, length of ITU and hospital stay. Graft function (heart = ejection fraction, lung = spirometry, liver = liver function and clotting indices).")
disease = Disease.find(76)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Transplantation (solid organ) antibody mediated rejection (updated 2022)",
    description: "Transplantation (solid organ) antibody mediated rejection (AMR). Previously, prior approval was required."
    )

Disease.create!(speciality: "Infectious Diseases",
                commissioning: "Prior panel approval not required (urgency acknowledged by policy)",
                priority: "2. Blue",
                regimen: "1 - 2 g/kg in divided doses.",
                criteria: "Patients with viral pneumonitis after heart or lung transplant (excluding influenza virus or patients with RSV or HPIV confined to upper respiratory tract and without risk factors such as old age, GVHD, lymphopenia, neutropenia, mismatched donor, HSCT within 1 month).",
                outcome: "Record the virus type (e.g. HSV, VZV, CMV, RSV, HPIV (human parainfluenza virus)). Reversal of radiological infiltrates, length of hospital stay, survival.")
disease = Disease.find(77)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Viral pneumonitis post transplantation (solid organ or HSCT) (updated 2022)",
    description: "Post transplantation (solid organ or haemopoietic stem cell transplantation (HSCT/ bone marrow transplantation)) viral pneumonitis."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 g/kg at 14 weeks pregnancy and again at 18 weeks with high dose oral prednisolone. Hydroxychloroquine is treatment of choice and Ig second line if refractory, e.g. in previous pregnancy, or intolerant.",
                criteria: "IVIg therapy can be given during pregnancy when history of autoimmune congenital heart block in at least one previous pregnancy AND
                          maternal anti-Ro or anti-La antibodies are present AND hydroxychloroquine not suitable. May also be given post-natally to newborn until absence of maternal antibodies if evidence of disease.",
                outcome: "Improvement in the degree of heart block at birth.")
disease = Disease.find(78)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Prevention of autoimmune congenital heart block (anti-Ro or anti-La) (updated 2022)",
    description: "Prevention of autoimmune congenital heart block (anti-Ro or anti-La) or paediatric myocarditis. Second line after hydroxychloroquine."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 - 1.5 g/kg course - two to three courses every 6 - 8 weeks to assess benefit, though long term use not commissioned!",
                criteria: "When sight threatened and failure of response to locally administered steroids and systemic steroids and when
                          immunosuppressives and biological agents inappropriate or ineffective. Anti TNF agents (infliximab, adalimumab) are treatments of choice and commissioned",
                outcome: "Improvement in sight.")
disease = Disease.find(79)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Autoimmune uveitis - short term use (updated 2022)",
    description: "Autoimmune uveitis, including Vogt-Koyanagi-Harada syndrome. The acute phase is normally responsive to high dose steroids so that immunoglobulin and immunosuppressives are
                  reserved for refractory cases. However, there might be an argument for using immunoglobulin earlier without prior approval if severe features of VKH (meningitis, extensive vitiligo, poliosis (white hair)). For reference, infliximab in Chrohn's
                  disease is expected to work over 6 weeks, appreciably slower than typical Ig effects."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 - 2 g/kg course divided over 2-5 days given long term typically every 1-2 months over 3 years (Ahmed et al., 2012). Adjust to frequency
                          that prevents relapses and trial withdrawal annually.",
                criteria: "Severely affected where corticosteroids with adjuvant agents, typically rituximab, ineffective or inappropriate. Clearly second line after rituximab, but consider rapidity of response to latter.",
                outcome: "Reduction in relapses, reduction in steroid therapy, improvement in quality of life, blisters, pruritis.")
disease = Disease.find(80)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Immunobullous diseases - long term use (updated 2022)",
    description: "Immunobullous diseases includes pemphigus vulgaris, pemphigoid, dermatitis herpetiformis, linear IgA disease and epidermolysis bullosa acquisita.
    In a metanalysis of Ig for pemphigus (17 cases), 70% had a beneficial response (Engineer & Ahmed, 2001), and so has been recommended when conventional therapy has failed.
    Epidermolysis bullosa acquisita is a chronic condition that often responds poorly to conventional therapy and there are case series describing the benefit of Ig (Engineer & Ahmed, 2001).
    Dermatitis herpetiformis is normally treated with dapsone and gluten diet withdrawal and there does not appear to be a role for Ig therapy. Linear IgA disease is an auoimmune sometimes drug
    related disase of blisters on skin, often in a ring pattern, or mucous membranes whose name comes from the linear deposition of IgA along the basement membrane
    on direct immunofluorescence. It occurs more in the elderly but there is a childhood form called chronic bullous disease of childhood. Severe cases may appear
    as toxic epidermal necrolysis. Ig therapy would typically be after drug withdrawal, steroids, tetracyclines, erythromycin, dapsone, colchicine or mycophenolate. There are
    single case reports describing its use."
    )


Disease.create!(speciality: "Other",
                commissioning: "Not commissioned and requires IFR (former left-hand Grey indication)",
                priority: "3. Grey",
                regimen: "2 g/kg course, repeated after 1 month. Subsequent courses if relapse thereafter at a minimum frequency to prevent relapse in conjunction with
                          ongoing standard therapy and wound care (avoiding debridement).",
                criteria: "Cases refractory to maximum tolerated doses of steroids and steroid sparing agents.",
                outcome: "Resolution of lesions.")
disease = Disease.find(81)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Pyoderma gangrenosum",
    description: "Salvage therapy for pyoderma gangrenosum refractory to other treatment (Cafardi et al., 2014)."
    )

Disease.create!(speciality: "Other",
                commissioning: "Not commissioned and requires IFR (former left-hand Grey indication))",
                priority: "3. Grey",
                regimen: "2 g/kg course for stabilisation of symptoms.",
                criteria: "To be given as part of an overall treatment strategy that may include steroids, immunosuppression and newer anti IL-1 and IL-6 biological agents.",
                outcome: "Improvement in features of systemic inflammation.")
disease = Disease.find(82)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Systemic juvenile idiopathic arthritis",
    description: "Systemic juvenile idiopathic arthritis is defined as arthritis lacking typical circulating autoantibodies but with several features of systemic inflammation including fever,
                  rashes, hepatosplenomegaly, lymphadenopathy or serositis. There is overlap with Still's disease, which does not necessarily have arthritis. It may be complicated by development
                  of macrophage activation syndrome (MAS)."
    )

Disease.create!(speciality: "Other",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "2 g/kg course for stabilisation of symptoms (Jayne et al., 2000) every 4 weeks; remission expected after 3 months. Discontinue if no improvement after this time.",
                criteria: "An optional treatment for short-term disease management if standard immunosuppression not suitable, e.g. severe infection, pregnancy",
                outcome: "Improvement in features of systemic inflammation.")
disease = Disease.find(83)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "ANCA associated systemic vasculitides (updated 2022)",
    description: "ANCA associated systemic vasculitis previously was a grey indication that included non-ANCA associated systemic vasculitis. Now the policy indicates that the role of Ig in ANCA negative small vessel cases is unclear and each case to be assessed on
    individual grounds. Therefore a SRIAP may approve non ANCA positive vasculitis in some cases. Note that systemic vasculitis is not primary cerebral angiitis. Treatment for this condition is high dose steroids combined with cyclophosphamide or rituximab or TNF antagonist such as infliximab.
    A recent review did not consider Ig as therapy (Beuker et al 2018), despite the recommendation of rituximab suggesting a B-cell component even with no circulating antibody. Possibly this is because there is usually a good response to steroids short-term."
    )

Disease.create!(speciality: "Other",
                commissioning: "Not commissioned and requires IFR (former left-hand Grey indication)",
                priority: "3. Grey",
                regimen: "2 g/kg course repeated after 4-6 weeks if relapse after good response (Mitzel-Khaoukhov et al., 2010).",
                criteria: "Consider in severe chronic cases where immunosuppressives or biological therapies not suitable.",
                outcome: "Improvement in features of systemic inflammation.")
disease = Disease.find(84)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Severe urticaria",
    description: "Severe intractable urticaria has been treated with immunoglobulin but does not appear in a recent review of management (Schaeffer et al., 2017) which instead
                  focuses on omalizumab or ciclospirin for cases refractory to antihistamines and short courses of steroids."
    )

Disease.create!(speciality: "Other",
                commissioning: "Not commissioned and requires IFR (former right-hand Grey indication)",
                priority: "3. Grey",
                regimen: "0.4-0.6 g/kg course repeated every 4 weeks until stabilisation of IgG levels.",
                criteria: "IgG levels more than 2SD below mean for age (see description) and normal B cells.",
                outcome: "Improvement in features of systemic inflammation.")
disease = Disease.find(85)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Atopic dermatitis/ eczema",
    description: "Atopic dermatitis/ eczema. Immunoglobulin use is now generally restricted to cases where atopic dermatitis is associated with
    transient hypogammaglobulinaemia of infancy (Izadi et al., 2018). Even in this circumstance there are no controlled studies."
    )

Disease.create!(speciality: "Other",
                commissioning: "Not commissioned and requires IFR (former right-hand Grey indication)",
                priority: "3. Grey",
                regimen: "Not established.",
                criteria: "Not established.",
                outcome: "Not established.")
disease = Disease.find(86)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Paraneoplastic disorders that are known not to be B- or T-cell mediated",
    description: "Paraneoplastic disorders that are known not to be B- or T-cell mediated include those associated with ectopic ACTH, ADH,
                parathyroid hormone related protein, insulin like substances, carcinoid, aldosterone, epidermal growth factor, glucagonoma,
                G-CSF, erythropoietin, mucins and fibroblast growth factor. There would be no particular justificaion to use immunoglobulin in
                such circumstances, unless there arose specific evidence to the contrary.")

Disease.create!(speciality: "Other",
                commissioning: "Not commissioned and requires IFR (former right-hand Grey indication)",
                priority: "3. Grey",
                regimen: "2 g/kg divided over 5 days single course.",
                criteria: "For stabilisation of haematological or cardiac manifestations where active disease and concurrent infection.",
                outcome: "Improvement in selective manifestations predefined by established severity criteria.")
disease = Disease.find(87)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "SLE without secondary immunocytopenias",
    description: "SLE without secondary immunocytopenias (including juvenile) is not normally treated with immunoglobulin unless there is a specific
    secondary antibody deficiency. However, if there is active disease and concomitant infection, immunosuppression may not be desirable and there are retrospective
    series showing benefit from immunoglobulin for specific manifestations such as haematological or cardiac involvement (Camara et al., 2014).")

Disease.create!(speciality: "Other",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(88)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Rheumatoid arthritis",
    description: "Rheumatoid arthritis."
    )

Disease.create!(speciality: "Other",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(89)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Asthma",
    description: "Asthma."
    )

Disease.create!(speciality: "Other",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(90)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Graves' ophthalmopathy",
    description: "Graves' ophthalmopathy."
    )

Disease.create!(speciality: "Other",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(91)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "IVF failure",
    description: "In vitro fertilisation (IVF) failure."
    )

Disease.create!(speciality: "Other",
                commissioning: "Shown to be ineffective (black)",
                priority: "4. Black",
                regimen: "Not recommended.",
                criteria: "Not recommended.",
                outcome: "Not recommended.")
disease = Disease.find(92)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Recurrent spontaneous pregnancy loss",
    description: "Recurrent spontaneous pregnancy loss."
    )

Disease.create!(speciality: "Haematology",
                commissioning: "Prior panel approval not required",
                priority: "1. Red",
                regimen: "1 g/kg single infusion or divided over 2 days; 2nd dose if still thrombotic or bleeding risk",
                criteria: "Confirmed by haematologist using up to date guidance, typically patient within 28 days of receipt of COVID 19 vaccine presenting with venous thrombosis (especially if venous sinus thrombosis) or possibly arterial thrombosis,
                 platelet count < 150 x 10^9/l and D-dimer > 4000.",
                outcome: "Platelet count")
disease = Disease.find(93)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "COVID-19 vaccine related thrombotic thrombocytopaenia (updated 2022)",
    description: "COVID-19 coronavirus vaccine related thrombotic thrombocytopaenia (VITT) - urgent treatment irrespective of degree of thrombocytopaenia."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "1. Blue",
                regimen: "2 g/kg over 5 days, repeated after 6 weeks. Titrate to optimal interval and dose thereafter. Discontinue if not effective after 2 courses.",
                criteria: "Defined paraneopastic syndrome (e.g. limbic encephalitis, sensory gangionopathy, cerebellar) AND evidence of a paraneoplastic associated tumour, e.g. small cell lung, ovarian, testicualr, breast, thymoma.",
                outcome: "Modified Rankin score, 10m walk, other appropriate validataed disability measure")
disease = Disease.find(94)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Paraneoplastic neurological syndromes (PNS) with or without evidence of autoantibodies (updated 2022)",
    description: "Paraneoplastic neurological syndromes (PNS) with or without evidence of autoantibodies. Note that encephalitic types with or without antibodies are considered under autoimmune encephalitides. The commissioners did not consider
    non encephalitic paraneoplastic syndromes (apart from opsoclonus myoclonus) with autoantibodies, e.g. sensory ganglionopathy, but clearly this would be in same category."
    )

Disease.create!(speciality: "Neurology",
                commissioning: "Prior panel approval required",
                priority: "2. Blue",
                regimen: "1 g/kg monthly (2 g/kg initial MOG disease dose or if relapse on 1 g/kg.",
                criteria: "Relapsed on or intolerant of steroids and immunosuppression (one immunosuppressant for MOG disease, 2 for NMO or Ab negative)",
                outcome: "Occurrence of treatment failure (significant relapse)")
disease = Disease.find(95)
DiseaseDescription.create!(
    disease_id: disease.id,
    name:  "Acute disseminated encephalomyelitis (ADEM), Devics (neuromyelitis optica spectrum) and transverse myelitis chronic relapse prevention (updated 2022)",
    description: "Non-MS CNS inflammatory disease covering the clinical phenotype of AQP4 ab disease, NMOSD, ADEM (with or without encephalopathy, including brainstem attacks), myelin ologodendrocyte associated glycoprotein (MOG) disease, transverse myelitis, optic neuritis. Specifically excludes MS, Behcets, sarcoid."
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


