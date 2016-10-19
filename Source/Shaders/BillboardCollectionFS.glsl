uniform sampler2D u_atlas;

varying vec2 v_textureCoordinates;

#ifdef RENDER_FOR_PICK
varying vec4 v_pickColor;
#else
varying vec4 v_color;
#endif

void main()
{
#ifdef RENDER_FOR_PICK
    vec4 vertexColor = vec4(1.0, 1.0, 1.0, 1.0);
#else
    vec4 vertexColor = v_color;
#endif

    vec4 color = texture2D(u_atlas, v_textureCoordinates) * vertexColor;

#ifdef RENDER_FOR_PICK
    if (color.a < 0.005)   // matches 0/255 and 1/255
    {
        discard;
    }
#else
#ifdef OPAQUE
    if (color.a < 0.995)   // matches < 254/255
    {
        discard;
    }
#else
    if (color.a >= 0.995)  // matches 254/255 and 255/255
    {
        discard;
    }
#endif
#endif

#ifdef RENDER_FOR_PICK
    gl_FragColor = v_pickColor;
#else
    gl_FragColor = color;
#endif
}