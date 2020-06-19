datos <- read.csv("dinamicas.csv")
gl <- glm(bnb~salud+
            educacion+
            empleo+
            infraestructura+
            dist_inund+
            dist_rios+
            dist_snap+
            dist_urban+
            dist_vias+
            pendiente,
          family = "binomial",
          datos)
