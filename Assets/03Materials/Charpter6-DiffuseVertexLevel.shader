// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Charpter6/DiffuseVertexLevel" {
	Properties {
		_Diffuse ("Diffuse", Color) = (0,0,1,1)
	}
	SubShader {

		pass {

			Tags {"LightMode"="ForwardBase"}

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			fixed4 _Diffuse;

			struct a2v {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed3 color : COLOR;
			};

			v2f vert(a2v v) {
				v2f o;
				o.pos = mul(UNITY_MARTRIX_MVP, v.vertex);

				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

				fixed3 worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate( dot(worldNormal, worldLight) );

				o.color = ambient + diffuse;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				return fixed4(i.color, 1.0);
			}

			ENDCG
		}

	}
	FallBack "Diffuse"
}
