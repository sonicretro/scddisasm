using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class Marker3D : ObjectDefinition
	{
		private Sprite img_booster;
		private Sprite img_sonic;


		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/3d_boost.nem", CompressionType.Nemesis);
			img_booster = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/3d_boost.asm", 1, 0);

			art_file = LevelData.ReadFile("../src/gfx/r1/player.unc", CompressionType.Uncompressed);
			byte[] map = LevelData.ASMToBin("../src/sprites/r1/player.asm", EngineVersion.SCD);
			byte[] plc = LevelData.ASMToBin("../src/sprites/r1/player_gfx.asm", EngineVersion.SCD);
			img_sonic = ObjectHelper.MapDPLCToBmp(art_file, map, plc, 23, 0, true);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "3D Marker"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}

		public override Sprite Image
		{
			get { return img_booster; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return new Sprite(img_booster, subtype != 0, false);
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (((SCDObjectEntry)obj).SubType2 != 0)
				return new Sprite(img_sonic, obj.SubType != 0, false);
			return new Sprite(img_booster, obj.SubType != 0, false);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}

		public override bool GetDebug(ObjectEntry obj)
		{
			return ((SCDObjectEntry)obj).SubType2 != 0;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Flipped", typeof(bool), "Extended", "If true, the marker is flipped horizontally", null,
				(obj) => { return (obj.SubType & 0x01) == 0x01; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0x01) | ((bool)value ? 0x01 : 0x00))),

			new PropertySpec("Type", typeof(int), "Extended", "The type of marker", null, new Dictionary<string, int>
				{
					{ "Booster", 0x00 },
					{ "Fall", 0x01 },
				},
				(obj) => { return ((SCDObjectEntry)obj).SubType2 & 0x01; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~0x01) | ((int)value & 0x01)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
