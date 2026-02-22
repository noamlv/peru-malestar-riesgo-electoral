# Causal-lite (IPW/AIPW)

**Metodo:** ajuste por confusores observables (demografia + clima politico) con ATE por IPW y AIPW.

| Escenario | Efecto AIPW (pp) | IC95% | p bootstrap | Sig. 0.05 |
|---|---:|---|---:|---|
| Percibir corrupcion (P8X=Si) -> Aprobacion presidencial | -25.22 | [-29.89, -19.56] | 0.0000 | Si |
| Percibir corrupcion (P8X=Si) -> Indecision voto diputados | 3.24 | [-6.06, 14.02] | 0.4640 | No |
| Creer que medida de moto ayuda (P53=Si) -> Aprobacion presidencial | 3.12 | [-0.80, 7.71] | 0.0880 | No |
| Creer que medida de moto ayuda (P53=Si) -> Indecision voto diputados | 0.92 | [-5.06, 8.20] | 0.7280 | No |

Interpretacion: efecto positivo en aprobacion = mejora; efecto positivo en indecision = mayor volatilidad.
