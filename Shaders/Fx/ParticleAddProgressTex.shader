Shader "Inception-Fx/AdditiveProgressTex" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	 _Progress("Progress", float) = 1
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha One
	//ColorMask RGB
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
	
	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//#pragma  gles d3d9 gles3 metal
			//#pragma multi_compile_particles

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
			fixed _Progress;
			
			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};
			
			float4 _MainTex_ST;

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				return o;
			}

			sampler2D_float _CameraDepthTexture;
			
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 c =  i.color * _TintColor * tex2D(_MainTex, i.texcoord);
				
				
				if( i.texcoord.x > _Progress)
				{
					c.a = 0;
				}
				return c;
			}
			ENDCG 
		}
	}	
}
}
